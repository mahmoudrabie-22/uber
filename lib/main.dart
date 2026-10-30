import 'package:flutter/material.dart';
import 'package:uber/core/constants/strings.dart';
import 'package:uber/core/routers/app_routers.dart';

void main() {
  runApp(Uber(appRouters: AppRouters()));
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
