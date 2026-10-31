import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:uber/core/constants/colors.dart';
import 'package:uber/core/constants/styles.dart';
import 'package:uber/features/signup/data/models/country_model.dart';
import 'package:uber/features/signup/presentation/widgets/choose_country.dart';
import 'package:uber/features/signup/presentation/widgets/custom_button.dart';
import 'package:uber/features/signup/presentation/widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController _textEditingController;
  CountryModel? countryModel;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Text(
                  'Welcome to Uber',
                  style: Styles.white28Weight600.copyWith(color: Colors.black),
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
                        textEditingController: _textEditingController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                CustomButton(
                  bgColor: Colors.black,
                  children: [Text('Continue', style: Styles.white16)],
                ),
                SizedBox(height: 14),
                CustomOrDivider(),
                SizedBox(height: 14),
                CustomButton(
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
                  bgColor: greyButton,
                  children: [
                    Icon(Icons.mail, size: 20),
                    SizedBox(width: 10),
                    Text('Continue with Email', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 14),
                CustomOrDivider(),
                SizedBox(height: 14),
                CustomButton(
                  bgColor: Colors.white,
                  children: [
                    Icon(Icons.search, size: 20),
                    SizedBox(width: 10),
                    Text('Find my account', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 22),
                Text(
                  'You consent to receive a verification code by text or Whatsapp. Message and data rates may apply.',
                  style: TextStyle(fontSize: 12, color: Color(0xff6B7280)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomOrDivider extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(height: 12, thickness: 1, color: Color(0xffD1D5DB)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text('or'),
        ),
        Expanded(
          child: Divider(height: 12, thickness: 1, color: Color(0xffD1D5DB)),
        ),
      ],
    );
  }
}
