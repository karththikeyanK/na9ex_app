import 'package:flutter/material.dart';
import 'package:na9ex_app/pages/splash/splash_screen.dart';

class SplashHome extends StatefulWidget {
  const SplashHome({super.key});

  @override
  SplashHomeState createState() {
    return SplashHomeState();
  }
}

class SplashHomeState extends State<SplashHome> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 10),(){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_)=> const SplashScreen(),
        ),
      );
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[25],
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),

        ),
      ),
    );
  }

}