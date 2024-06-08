import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:na9ex_app/constants.dart';

import '../Model/login_request.dart';
import '../pages/admin/admin_home.dart';
import 'api_client.dart';

class LoginActivity {

  Future<void> loginOnClick(BuildContext context, String username, String password) async {
    log("NA9EX::LoginActivity::LoginClick()::Username: $username");
    var authenticationRequest = AuthenticationRequest(
      email: username,
      password: password,
    );
    log("NA9EX::LoginActivity::LoginClick()::Email: ${authenticationRequest.email}");
    try {
      var loginResponse = await ApiClient().login(context, authenticationRequest);
      if (loginResponse.data.role == 'ADMIN') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminHomePage()),
        );
      }
    } catch (e) {
      log("NA9EX::LoginActivity::LoginClick()::Login failed with exception: $e");
      showCustomAlert(context, "Sever Error", "Please wait for a moment.", "error");
    }
  }
}