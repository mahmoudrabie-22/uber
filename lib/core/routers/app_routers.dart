import 'package:flutter/material.dart';
import 'package:uber/core/constants/strings.dart';
import 'package:uber/features/second_splash/second_splash_screen.dart';
import 'package:uber/features/signup/presentation/signup_screen.dart';

class AppRouters {

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case secondSplashScreenRoute:
        return MaterialPageRoute(builder: (_) => const SecondSplashScreen());
      case signupScreenRoute:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}