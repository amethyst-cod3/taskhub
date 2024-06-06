import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskhub/firebase/services/firebase_auth_service.dart';
import 'package:taskhub/storage/auth_local_storage.dart';

class FirebaseAuthController with ChangeNotifier {
  final FirebaseAuthService authService = FirebaseAuthService();
  User? _user;
  String? errorMessage;
  late BuildContext _context;

  /// Initializing the controller listening to the Firebase Auth state changes
  FirebaseAuthController(/*BuildContext context*/) {
    authService.firebaseAuthStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
    //_context = context;
  }

  User? get user => _user;
  String? get error => errorMessage;

  Future<void> signIn(String email, String password) async {
    try {
      _user = await authService.signInWithEmailAndPassword(
          email.trim(), password.trim());
      errorMessage = null;

      if (_user != null) {
        await AuthLocalStorage.saveCurrentUser(_user!.uid);
        //GoRouter.of(_context).go('/homePage');
      }
    } catch (e) {
      _user = null;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    try {
      _user = await authService.createUserWithEmailAndPassword(
          email.trim(), password.trim());
      errorMessage = null;
    } catch (e) {
      _user = null;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    await AuthLocalStorage.removeCurrentUser();
    _user = null;
    notifyListeners();
  }

  User? getCurrentUser() {
    _user = authService.getCurrentUser();
    return _user;
  }

  Future<void> signInWithStoredUserId(String userId) async {
    try {
      _user = await authService.signInWithUserId(userId);
      errorMessage = null;

      if (_user != null) {
        //GoRouter.of(_context).go('/homePage');
      }
    } catch (e) {
      _user = null;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
