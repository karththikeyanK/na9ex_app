import 'package:flutter/material.dart';
import 'package:na9ex_app/service/login_activity.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginActivity loginActivity = LoginActivity();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Change to true
      backgroundColor: Colors.blue[25],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 50),
                      Image.asset('assets/logo.png'),
                      const Text(
                        'NA9EX',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF074173),
                        ),
                      ),
                      const SizedBox(height: 50),
                      TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Color(0xFF074173)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Color(0xFF074173)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => loginActivity.loginOnClick(
                              context,
                              usernameController.text,
                              passwordController.text),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF074173)),
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(color: Color(0xFF074173))),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container()), // Add this line to push the content up
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
