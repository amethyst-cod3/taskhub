import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhub/models/task_model.dart';

class DatabaseService {
  DatabaseService({this.uid});

  final String? uid;

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
      return Task(
        id: doc.get('id') ?? '',
        title: doc.get('title') ?? '',
        description: doc.get('description') ?? '',
        isCompleted: doc.get('isCompleted') ?? false,
      );
    }).toList();
  }

  /// Task getter
  Stream<List<Task>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }

  /// TASK FUNCTIONS
  // Add task
  Future<void> addTask(
      String tempId, String title, String description, bool isCompleted) async {
    DocumentReference documentRef = await taskCollection.add({
      'id': tempId, // Mark the task id as a temporal one
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    });

    // Obtain a task reference id and save it as the task id
    String taskId = documentRef.id;
    await documentRef.update({'id': taskId});
  }

  // Edit task
  Future<void> editTask(String taskId, String title, String description) async {
    return await taskCollection.doc(taskId).update({
      'title': title,
      'description': description,
    });
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
}
