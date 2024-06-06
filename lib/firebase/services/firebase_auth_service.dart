import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get firebaseAuthStateChanges => firebaseAuth.authStateChanges();

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredentials =
          await firebaseAuth.signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      return userCredentials.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredentials =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      return userCredentials.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<User?> signInWithUserId(String userId) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithCustomToken(userId);
      return userCredential.user;
    } catch (e) {
      throw Exception('Error signing in with stored user ID: $e');
    }
  }
}
