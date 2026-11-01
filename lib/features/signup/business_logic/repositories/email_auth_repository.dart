import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber/features/signup/data/services/email_auth_service.dart';

class EmailAuthRepository {
  final EmailAuthService _emailAuthService;
  EmailAuthRepository({required this._emailAuthService});

  Future<UserCredential> signInOrRegister({
    required String email,
    required String password,
  }) async {
    try {
      return await _emailAuthService.signInOrRegister(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }
}
