import 'package:uber/features/signup/data/models/user_model.dart';
import 'package:uber/features/signup/data/services/google_auth_service.dart';

class GoogleAuthRepository {
  final GoogleAuthService googleAuthService;

  GoogleAuthRepository({required this.googleAuthService});

  Future<UserModel?> signInWithGoogle() async {
    final userCredential = await googleAuthService.signInWithGoogle();

    final user = userCredential?.user;

    if (user == null) return null;

    return UserModel.fromFirebase(user);
  }
}
