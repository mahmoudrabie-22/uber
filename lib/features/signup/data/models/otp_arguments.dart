class OtpArguments {
  final String phoneNumber;
  final String verificationId;
  final int? resendToken;

  OtpArguments({
    required this.phoneNumber,
    required this.verificationId,
    this.resendToken,
  });
}