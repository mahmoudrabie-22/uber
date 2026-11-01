import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class EmailAuthService {
  final FirebaseAuth _firebaseAuth;

  EmailAuthService({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserCredential> signInOrRegister({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );
      }

      rethrow;
    }catch (e) {
      debugPrint('Error in signInOrRegister: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
