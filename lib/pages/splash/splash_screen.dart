import 'package:flutter/material.dart';
import 'package:na9ex_app/pages/login_page.dart';
import 'package:na9ex_app/pages/pin_screen.dart';

import '../../service/utills/pin_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    if(await isLoggedIn()){
      Future.delayed(const Duration(seconds: 2),()
      {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const PinEntryScreen("Enter"),
          ),
        );
      }
      );
    }
    else{
      Future.delayed(const Duration(seconds: 2),(){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_)=> LoginPage(),
          ),
        );
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[25],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: [
              Image.asset('assets/logo.png'),
              const SizedBox(height: 20),
              const Text(
                'NA9EX',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF074173)),
              ),
            ],
          ),
        ),
      ),
    );
  }

}