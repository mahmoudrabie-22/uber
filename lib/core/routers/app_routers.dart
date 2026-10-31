import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/core/constants/strings.dart';
import 'package:uber/features/second_splash/get_started_screen.dart';
import 'package:uber/features/second_splash/second_splash_screen.dart';
import 'package:uber/features/signup/business_logic/get_countries_repository.dart';
import 'package:uber/features/signup/cubit/get_all_countries_cubit.dart';
import 'package:uber/features/signup/presentation/screens/signup_screen.dart';

class AppRouters {
  final GetCountriesRepository getCountriesRepository;

  AppRouters({required this.getCountriesRepository});
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case secondSplashScreenRoute:
        return MaterialPageRoute(builder: (_) => const SecondSplashScreen());
      case signupScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => GetAllCountriesCubit(
              getCountriesRepository: getCountriesRepository,
            ),
            child: const SignupScreen(),
          ),
        );
      case getStartedScreenRoute:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
