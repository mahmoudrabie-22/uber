part of 'auth_phone_cubit.dart';

@immutable
sealed class AuthPhoneState {}

final class AuthPhoneInitial extends AuthPhoneState {}

final class AuthPhoneLoading extends AuthPhoneState {}

final class AuthPhoneCodeSent extends AuthPhoneState {
  final String verificationId;
  final int? resendToken;

  AuthPhoneCodeSent({required this.verificationId, this.resendToken});
}

final class AuthPhoneVerifying extends AuthPhoneState {}

final class AuthPhoneCompleted extends AuthPhoneState {
  final UserModel userModel;

  AuthPhoneCompleted({required this.userModel});
}

final class AuthPhoneFailed extends AuthPhoneState {
  final String error;

  AuthPhoneFailed({required this.error});
}
