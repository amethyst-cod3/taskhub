import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhub/models/task_model.dart';

class DatabaseService {
  DatabaseService({this.uid});

  final String? uid;

  /// Collection reference
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future updateUserData(
      String title, String description, bool isCompleted) async {
    return await taskCollection.doc(uid).set({
      'title': title,
      'description': description,
      'isCompleted': false,
    });
  }

  /// Task list from snapshot
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Task(
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
}
