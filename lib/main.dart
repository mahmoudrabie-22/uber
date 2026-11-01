import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uber/core/constants/strings.dart';
import 'package:uber/core/routers/app_routers.dart';
import 'package:uber/features/signup/business_logic/auth_phone/auth_phone_cubit.dart';
import 'package:uber/features/signup/business_logic/repositories/auth_phone_repository.dart';
import 'package:uber/features/signup/business_logic/repositories/get_countries_repository.dart';
import 'package:uber/features/signup/data/services/get_countries_web_services.dart';
import 'package:uber/features/signup/data/services/phone_auth_service.dart';
import 'package:uber/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    Uber(
      appRouters: AppRouters(
        getCountriesRepository: getIt<GetCountriesRepository>(),
      ),
    ),
  );
}

final getIt = GetIt.instance;
void configureDependencies() {
  getIt.registerSingleton<GetCountriesWebServices>(GetCountriesWebServices());
  getIt.registerLazySingleton<GetCountriesRepository>(
    () => GetCountriesRepository(webServices: getIt<GetCountriesWebServices>()),
  );

  
}

class Uber extends StatelessWidget {
  const Uber({super.key, required this.appRouters});
  final AppRouters appRouters;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: secondSplashScreenRoute,
      onGenerateRoute: appRouters.generateRoute,
    );
  }
}
