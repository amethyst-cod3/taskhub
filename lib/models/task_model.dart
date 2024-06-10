import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.creationDate,
    required this.lastEdited,
  });

  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime creationDate;
  final DateTime lastEdited;

  // Create a factory constructor to parse from a Firestore document
  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Task(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      creationDate: (data['creationDate'] as Timestamp).toDate(),
      lastEdited: (data['lastEdited'] as Timestamp).toDate(),
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'creationDate': Timestamp.fromDate(creationDate),
      'lastEdited': Timestamp.fromDate(lastEdited),
    };
  }
}
