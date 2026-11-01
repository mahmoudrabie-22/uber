import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/constants/strings.dart';
import 'package:uber/core/di/dependency_injection.dart';
import 'package:uber/core/routers/app_routers.dart';

import 'package:uber/features/signup/business_logic/repositories/get_countries_repository.dart';

import 'package:uber/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  configureDependencies();

  runApp(
    Uber(
      appRouters: AppRouters(
        getCountriesRepository: getIt<GetCountriesRepository>(),
      ),
    ),
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
