import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskhub/models/user_model.dart';
import 'package:taskhub/services/database_service.dart';
import 'package:taskhub/styles/colors.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _databaseService = DatabaseService();

  User? get currentUser => _auth.currentUser;

  /// Create an User (UserModel) object based on a User (FirebaseUser old nomenclature)
  UserModel? _userFromFirebase(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  /// Auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  /// Get user info
  Future<Map<String, dynamic>?> getUserInfo(String uid) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// USER CREDENTIALS PROVIDERS
  // Anonymous provider
  Future<UserModel?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFirebase(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Email and password provider
  Future<UserModel?> signIn(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User? user = userCredential.user;
      if (context.mounted) _navigateToHomePage(context);
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) _handleAuthException(context, e);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<UserModel?> signUp(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      User? user = userCredential.user;
      await _databaseService.saveUserInfo(user!.uid, email);
      if (context.mounted) _navigateToHomePage(context);
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) _handleAuthException(context, e);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
  // Add more providers //

  /// Sign out
  Future<void> signOut(BuildContext context) async {
    try {
      _navigateToWelcomePage(context);
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  /// Reset password
  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      if (context.mounted) {
        _showSuccessSnackBar(context, 'Password reset email sent.');
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) _handleAuthException(context, e);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Navigate to pages
  void _navigateToHomePage(BuildContext context) {
    context.go('/homePage');
  }

  void _navigateToWelcomePage(BuildContext context) {
    context.go('/welcomePage');
  }

  /// Error handling
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: CustomColor.purple,
      ),
    );
  }

  void _handleAuthException(BuildContext context, FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'invalid-email':
        message = 'The email address is not valid.';
        break;
      case 'wrong-password':
        message = 'Wrong password provided.';
        break;
      case 'user-not-found':
        message = 'No user found for that email.';
        break;
      case 'email-already-in-use':
        message = 'The email address is already in use by another account.';
        break;
      case 'weak-password':
        message = 'The password provided is too weak.';
        break;
      default:
        message = 'An unknown error occurred. Please try again.';
    }
    _showErrorSnackBar(context, message);
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: CustomColor.lightblue,
      ),
    );
  }
}
