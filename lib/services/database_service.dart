import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhub/models/task_model.dart';

class DatabaseService {
  DatabaseService({this.uid});

  final String? uid;

  /// USERS
  Future<void> saveUserInfo(String uid, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'uid': uid,
      'username': 'New user',
      'email': email,
      'avatar': 'default',
    });
  }

  Future<void> updateUsername(String uid, String username) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'username': username,
    });
  }

  Future getUserIdByEmail(String email) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (result.docs.isEmpty) return null;
    return result.docs.first['uid'];
  }

  /// --------------------

  /// TASKS
  /// Collection reference
  CollectionReference get taskCollection {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks');
  }

  /// Task list from snapshot
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Task.fromFirestore(doc);
    }).toList();
  }

  /// Task getter
  Stream<List<Task>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }

  // Stream<List<Task>> get sharedTasks {
  //   return FirebaseFirestore.instance
  //       .collectionGroup('tasks')
  //       .where('sharedWith', arrayContains: uid)
  //       .snapshots()
  //       .map(_taskListFromSnapshot);
  // }

  /// TASK FUNCTIONS
  // Add task
  Future<void> addTask(/*String tempId,*/ String title, String? description,
      bool isCompleted) async {
    final creationDate = DateTime.now();
    DocumentReference documentRef = await taskCollection.add({
      //'taskId': tempId, // Mark the task id as a temporal one
      'title': title,
      'description': description ?? '',
      'isCompleted': isCompleted,
      'creationDate': Timestamp.fromDate(creationDate),
      'lastEdited': Timestamp.fromDate(creationDate),
      'sharedWith': [uid],
    });

    // Obtain a task reference id and save it as the task id
    String taskId = documentRef.id;
    await documentRef.update({'taskId': taskId});
  }

  // Edit task
  Future<void> editTask(
    String taskId,
    String title,
    String? description,
    String oldDescription,
  ) async {
    final lastEdited = DateTime.now();
    await taskCollection.doc(taskId).update({
      'title': title,
      'description': description ?? oldDescription,
      'lastEdited': lastEdited,
    });

    QuerySnapshot sharedTasks = await FirebaseFirestore.instance
        .collectionGroup('tasks')
        .where('taskId', isEqualTo: taskId)
        .get();

    for (DocumentSnapshot doc in sharedTasks.docs) {
      //if (doc.id != taskId) {
      await doc.reference.update({
        'title': title,
        'description': description ?? oldDescription,
        'lastEdited': lastEdited,
      });
      //}
    }
  }

  // Update a task status
  Future<void> updateTaskStatus(String taskId, bool isCompleted) async {
    return await taskCollection.doc(taskId).update({
      'isCompleted': isCompleted,
    });
  }

  // Delete task
  Future<void> deleteTask(String taskId) async {
    return await taskCollection.doc(taskId).delete();
  }

  // Share task with another user
  Future<void> shareTaskWithUser(String taskId, String newUserId) async {
    DocumentReference taskRef = taskCollection.doc(taskId);

    await taskRef.update({
      'sharedWith': FieldValue.arrayUnion([newUserId])
    });

    DocumentSnapshot taskSnapshot = await taskRef.get();
    Map<String, dynamic> taskData = taskSnapshot.data() as Map<String, dynamic>;

    CollectionReference newUserTaskCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(newUserId)
        .collection('tasks');

    await newUserTaskCollection.doc(taskId).set(taskData);
  }

  /// --------------------
}
