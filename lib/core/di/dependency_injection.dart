import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:uber/features/signup/business_logic/repositories/get_countries_repository.dart';
import 'package:uber/features/signup/business_logic/repositories/google_auth_repository.dart';

import 'package:uber/features/signup/data/services/get_countries_web_services.dart';
import 'package:uber/features/signup/data/services/google_auth_service.dart';
import 'package:uber/features/signup/data/services/phone_auth_service.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton<GetCountriesWebServices>(
    GetCountriesWebServices(),
  );

  getIt.registerLazySingleton<GetCountriesRepository>(
    () => GetCountriesRepository(
      webServices: getIt<GetCountriesWebServices>(),
    ),
  );

  getIt.registerLazySingleton<PhoneAuthService>(
    () => PhoneAuthService(
      firebaseAuth: FirebaseAuth.instance,
    ),
  );

  getIt.registerLazySingleton<GoogleAuthService>(
    () => GoogleAuthService(),
  );

  getIt.registerLazySingleton<GoogleAuthRepository>(
    () => GoogleAuthRepository(
      googleAuthService: getIt<GoogleAuthService>(),
    ),
  );
}