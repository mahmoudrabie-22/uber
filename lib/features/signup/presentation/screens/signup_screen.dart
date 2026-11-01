import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:uber/core/constants/colors.dart';
import 'package:uber/core/constants/strings.dart';
import 'package:uber/core/constants/styles.dart';
import 'package:uber/features/signup/business_logic/auth_phone/auth_phone_cubit.dart';
import 'package:uber/features/signup/business_logic/google_auth_cubit/google_auth_cubit.dart';
import 'package:uber/features/signup/data/models/country_model.dart';
import 'package:uber/features/signup/data/models/otp_arguments.dart';
import 'package:uber/features/signup/presentation/widgets/choose_country.dart';
import 'package:uber/features/signup/presentation/widgets/custom_button.dart';
import 'package:uber/features/signup/presentation/widgets/custom_or_divider.dart';
import 'package:uber/features/signup/presentation/widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  CountryModel? countryModel;
  String? _phoneNumber;
  OtpArguments? args;
  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleAuthCubit, GoogleAuthState>(
      listener: (context, state) {
        if (state is GoogleAuthSuccess) {
          Navigator.pushReplacementNamed(context, homeScreenRoute);
        }

        if (state is GoogleAuthFailure) {
          debugPrint('Google Auth Failure: ${state.errorMessage}');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: BlocConsumer<AuthPhoneCubit, AuthPhoneState>(
        listener: (context, state) {
          if (state is AuthPhoneCodeSent) {
            args = OtpArguments(
              phoneNumber: _phoneNumber!,
              verificationId: state.verificationId,
              resendToken: state.resendToken,
            );
            Navigator.pushNamed(context, otpScreenRoute, arguments: args);

            debugPrint(
              'Verification ID in sign up screen: ${state.verificationId}',
            );
          }

          if (state is AuthPhoneFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }

          if (state is AuthPhoneCompleted) {
            Navigator.pushNamed(context, homeScreenRoute);
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  SizedBox(height: 24),
                  Lottie.asset(
                    'assets/animation/man_waiting_car.json',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.contain,
                    repeat: false,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24),
                          Text(
                            'Welcome to Uber',
                            style: Styles.white28Weight600.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 14),
                          Row(
                            children: [
                              ChooseCountry(
                                onCountrySelected: (CountryModel value) {
                                  countryModel = value;
                                  setState(() {});
                                },
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomTextForm(
                                  countryModel: countryModel,
                                  onChanged: (value) {
                                    _phoneNumber = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          CustomButton(
                            onTap: () {
                              if (state is AuthPhoneLoading) return;

                              if (!_formKey.currentState!.validate()) return;

                              if (countryModel == null) return;

                              final phone = _phoneNumber!.trim();

                              final formattedPhone =
                                  '+${countryModel!.callingCode}${phone.startsWith('0') ? phone.substring(1) : phone}';

                              BlocProvider.of<AuthPhoneCubit>(context)
                                  .sendOTP(formattedPhone);
                            },
                            bgColor: Colors.black,
                            children: [
                              if (state is AuthPhoneLoading)
                                const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              else
                                Text('Continue', style: Styles.white16),
                            ],
                          ),
                          SizedBox(height: 14),
                          CustomOrDivider(),
                          SizedBox(height: 14),
                          CustomButton(
                            onTap: () {
                              debugPrint('Google button clicked');

                              BlocProvider.of<GoogleAuthCubit>(context)
                                  .signInWithGoogle();
                            },
                            bgColor: greyButton,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: SvgPicture.asset(
                                  'assets/logos/google.svg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Continue with Google',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          CustomButton(
                            onTap: () {},
                            bgColor: greyButton,
                            children: [
                              Icon(Icons.mail, size: 20),
                              SizedBox(width: 10),
                              Text(
                                'Continue with Email',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          CustomOrDivider(),
                          SizedBox(height: 14),
                          CustomButton(
                            onTap: () {},
                            bgColor: Colors.white,
                            children: [
                              Icon(Icons.search, size: 20),
                              SizedBox(width: 10),
                              Text(
                                'Find my account',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 22),
                          Text(
                            'You consent to receive a verification code by text or Whatsapp. Message and data rates may apply.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
