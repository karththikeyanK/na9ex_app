// main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:na9ex_app/pages/splash/splash_home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    precacheImage(const AssetImage('assets/logo.png'), context);

    return MaterialApp(
      title: 'NA9EX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const SplashHome(), // Set LoginPage as the home
    );
  }
}
