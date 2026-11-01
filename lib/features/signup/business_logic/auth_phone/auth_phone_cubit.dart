import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uber/features/signup/data/models/user_model.dart';
import 'package:uber/features/signup/business_logic/repositories/auth_phone_repository.dart';

part 'auth_phone_state.dart';

class AuthPhoneCubit extends Cubit<AuthPhoneState> {
  final AuthPhoneRepository authPhoneRepository;

  AuthPhoneCubit({required this.authPhoneRepository})
    : super(AuthPhoneInitial());

  Future<void> sendOTP(String phoneNumber) async {
    emit(AuthPhoneLoading());

    try {
      await authPhoneRepository.sendOTP(
        phoneNumber: phoneNumber,

        onCodeSent: (phoneAuthModel) {
          emit(
            AuthPhoneCodeSent(
              verificationId: phoneAuthModel.verificationId,
              resendToken: phoneAuthModel.resendToken,
            ),
          );
        },

        onVerificationCompleted: (user) {
          emit(AuthPhoneCompleted(userModel: user));
        },

        onError: (error) {
          emit(AuthPhoneFailed(error: error));
        },
      );
    } catch (e) {
      emit(AuthPhoneFailed(error: e.toString()));
    }
  }

  Future<bool> verifyOTP({
    required String verificationId,
    required String smsCode,
  }) async {
    emit(AuthPhoneVerifying());

    try {
      final user = await authPhoneRepository.verifyOTP(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      if (user != null) {
        emit(AuthPhoneCompleted(userModel: user));
        return true;
      }

      emit(AuthPhoneFailed(error: 'Verification failed'));
      return false;
    } catch (e) {
      emit(AuthPhoneFailed(error: e.toString()));
      return false;
    }
  }
}
