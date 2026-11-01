import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_kit/flutter_otp_kit.dart';
import 'package:uber/core/constants/strings.dart';
import 'package:uber/features/signup/business_logic/auth_phone/auth_phone_cubit.dart';
import 'package:uber/features/signup/data/models/otp_arguments.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.args});

  final OtpArguments args;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthPhoneCubit, AuthPhoneState>(
          listener: (context, state) {
            if (state is AuthPhoneCompleted) {
              Navigator.pushReplacementNamed(context, navScreenRoute);
            }

            if (state is AuthPhoneFailed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
              print(state.error);
              print('in otp screen ${widget.args.verificationId}');
            }
          },
          builder: (context, state) {
            return OtpKit(
              secondaryColor: Colors.grey,
              fieldConfig: OtpFieldConfig.preset(OtpFieldPreset.modern),
              animationConfig: OtpAnimationConfig(
                enableAnimation: true,
                fieldFillAnimationType: FieldFillAnimationType.rotate,
                errorFieldAnimationType: ErrorFieldAnimationType.bounce,
              ),
              primaryColor: Colors.black,
              successColor: Colors.black,
              errorColor: Colors.red,
              fieldSpacing: 4,
              title: 'Welcome',
              subtitle:
                  'Enter the 6-digits code sent to your sms at ${widget.args.phoneNumber}',
              fieldCount: 6,
              onVerify: (String otp) async {
                await context.read<AuthPhoneCubit>().verifyOTP(
                  verificationId: widget.args.verificationId,
                  smsCode: otp,
                );

                return true;
              },
              onResend: () {},
            );
          },
        ),
      ),
    );
  }
}
