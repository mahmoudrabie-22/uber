import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/core/constants/colors.dart';
import 'package:uber/core/constants/strings.dart';
import 'package:uber/core/constants/styles.dart';
import 'package:uber/features/signup/business_logic/email_auth_cubit/email_auth_cubit.dart';
import 'package:uber/features/signup/presentation/widgets/custom_text_field.dart';

class EnterEmailAndPasswordScreen extends StatefulWidget {
  const EnterEmailAndPasswordScreen({super.key});
  @override
  State<EnterEmailAndPasswordScreen> createState() =>
      _EnterEmailAndPasswordScreenState();
}

class _EnterEmailAndPasswordScreenState
    extends State<EnterEmailAndPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailAuthCubit, EmailAuthState>(
      listener: (context, state) {
        if (state is EmailAuthSuccess) {
          Navigator.pushReplacementNamed(context, navScreenRoute);
        }

        if (state is EmailAuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 40.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'What\'s your email address?',
                      style: Styles.white28Weight600.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomTextForm(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String p1) {
                        email = p1;
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address';
                        }
                        // You can add more validation logic here if needed
                        return null;
                      },

                      hint: 'name@example.com',
                    ),
                    SizedBox(height: 16),
                    CustomTextForm(
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (String p1) {
                        password = p1;
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      hint: 'Enter a password',
                      isObscure: true,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(),
                        ForwardButton(
                          onTap: () {
                            if (!_formKey.currentState!.validate()) return;

                            context.read<EmailAuthCubit>().signInOrRegister(
                              email: email.trim(),
                              password: password,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ForwardButton extends StatelessWidget {
  const ForwardButton({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 133,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(shape: BoxShape.circle, color: myGray),
        child: Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }
}
