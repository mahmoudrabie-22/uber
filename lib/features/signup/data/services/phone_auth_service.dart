import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber/features/signup/data/models/phone_auth_model.dart';
import 'package:uber/features/signup/data/models/user_model.dart';

class PhoneAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId;

  Future<void> sendOTP({
    required String phoneNumber,
    required Function(PhoneAuthModel model) onCodeSent,
    required Function(UserModel user) onVerificationCompleted,
    required Function(String error) onError,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      verificationCompleted: (credential) async {
        try {
          final result = await _auth.signInWithCredential(credential);

          if (result.user != null) {
            onVerificationCompleted(UserModel.fromFirebase(result.user!));
          }
        } catch (e) {
          onError(e.toString());
        }
      },

      verificationFailed: (e) {
        onError(e.message ?? 'Something went wrong');
      },

      codeSent: (verificationId, resendToken) {
        onCodeSent(
          PhoneAuthModel(
            verificationId: verificationId,
            resendToken: resendToken,
          ),
        );
      },

      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<UserModel?> verifyOTP(String verifictionID ,String otp) async {
    verificationId=verifictionID;
    if (verificationId == null) return null;

    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: otp,
    );

    final userCredential = await _auth.signInWithCredential(credential);

    final user = userCredential.user;

    if (user == null) return null;

    return UserModel.fromFirebase(user);
  }
}
