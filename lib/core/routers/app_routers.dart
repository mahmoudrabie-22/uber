import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/core/constants/strings.dart';
import 'package:uber/core/di/dependency_injection.dart';
import 'package:uber/features/home/presentation/screens/home_screen.dart';
import 'package:uber/features/second_splash/get_started_screen.dart';
import 'package:uber/features/second_splash/second_splash_screen.dart';
import 'package:uber/features/signup/business_logic/auth_phone/auth_phone_cubit.dart';
import 'package:uber/features/signup/business_logic/google_auth_cubit/google_auth_cubit.dart';
import 'package:uber/features/signup/business_logic/repositories/auth_phone_repository.dart';
import 'package:uber/features/signup/business_logic/repositories/get_countries_repository.dart';
import 'package:uber/features/signup/business_logic/get_countries_cubit/get_all_countries_cubit.dart';
import 'package:uber/features/signup/business_logic/repositories/google_auth_repository.dart';
import 'package:uber/features/signup/data/models/otp_arguments.dart';
import 'package:uber/features/signup/data/services/phone_auth_service.dart';
import 'package:uber/features/signup/presentation/screens/otp_screen.dart';
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
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => GetAllCountriesCubit(
                  getCountriesRepository: getCountriesRepository,
                ),
              ),

              BlocProvider(
                create: (context) => AuthPhoneCubit(
                  authPhoneRepository: AuthPhoneRepository(
                    phoneAuthService: getIt<PhoneAuthService>(),
                  ),
                ),
              ),

              BlocProvider(
                create: (context) => GoogleAuthCubit(
                  googleAuthRepository: getIt<GoogleAuthRepository>(),
                ),
              ),
            ],
            child: const SignupScreen(),
          ),
        );
      case getStartedScreenRoute:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());

      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case otpScreenRoute:
        OtpArguments args = settings.arguments as OtpArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthPhoneCubit(
              authPhoneRepository: AuthPhoneRepository(
                phoneAuthService: PhoneAuthService(
                  firebaseAuth: FirebaseAuth.instance,
                ),
              ),
            ),
            child: OTPScreen(args: args),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
