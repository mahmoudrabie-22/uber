class PhoneAuthModel {
  final String verificationId;
  final int? resendToken;

  PhoneAuthModel({
    required this.verificationId,
    this.resendToken,
  });
}