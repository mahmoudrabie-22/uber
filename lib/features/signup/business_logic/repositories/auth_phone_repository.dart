import 'package:uber/features/signup/data/models/phone_auth_model.dart';
import 'package:uber/features/signup/data/models/user_model.dart';
import 'package:uber/features/signup/data/services/phone_auth_service.dart';

class AuthPhoneRepository {
  final PhoneAuthService phoneAuthService;
  AuthPhoneRepository({required this.phoneAuthService});

  Future<void> sendOTP({
    required String phoneNumber,
    required Function(PhoneAuthModel) onCodeSent,
    required Function(UserModel user) onVerificationCompleted,
    required Function(String error) onError,
  }) async {
    await phoneAuthService.sendOTP(
      phoneNumber: phoneNumber,
      onCodeSent: onCodeSent,
      onVerificationCompleted: onVerificationCompleted,
      onError: onError,
    );
  }

  Future<UserModel?> verifyOTP({
    required String? verificationId,
    required String smsCode,
  }) async {
    if (verificationId == null) return null;
    final user = await phoneAuthService.verifyOTP(verificationId, smsCode);

    return user;
  }
}
