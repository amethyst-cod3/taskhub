import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.uid,
    this.username,
    this.email,
    this.avatar,
  });

  final String? uid;
  final String? username;
  final String? email;
  final String? avatar;

  // Create a factory constructor to parse from a Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserModel(
      uid: data['uid'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      avatar: data['avatar'] ?? '',
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'avatar': avatar,
    };
  }
}
