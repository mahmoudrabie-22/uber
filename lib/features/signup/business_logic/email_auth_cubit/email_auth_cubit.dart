import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:uber/features/signup/business_logic/repositories/email_auth_repository.dart';

part 'email_auth_state.dart';

class EmailAuthCubit extends Cubit<EmailAuthState> {
  final EmailAuthRepository _emailAuthRepository;

  EmailAuthCubit({required this._emailAuthRepository})
    : super(EmailAuthInitial());

  Future<void> signInOrRegister({
    required String email,
    required String password,
  }) async {
    emit(EmailAuthLoading());

    try {
      final userCredential = await _emailAuthRepository.signInOrRegister(
        email: email,
        password: password,
      );

      emit(EmailAuthSuccess(userCredential: userCredential));
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Error Code: ${e.code}');
      debugPrint('Firebase Error Message: ${e.message}');

      String message;

      switch (e.code) {
        case 'wrong-password':
          message = 'Incorrect password';
          break;
        case 'user-not-found':
          message = 'Account not found';
          break;
        case 'invalid-credential':
          message = 'Invalid email or password';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        case 'weak-password':
          message = 'Password is too weak';
          break;
        case 'email-already-in-use':
          message = 'This email is already registered';
          break;
        default:
          message = 'Authentication failed. Please try again.';
      }

      emit(EmailAuthFailure(errorMessage: message));
    } catch (e) {
      debugPrint('Unexpected Error: $e');

      emit(
        EmailAuthFailure(
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );
    }
  }
}
