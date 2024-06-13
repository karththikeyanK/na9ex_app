import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:na9ex_app/constants.dart';
import 'package:na9ex_app/service/utills/pin_service.dart';

import '../Model/login_request.dart';
import '../pages/admin/admin_home.dart';
import 'api_client.dart';

class LoginActivity {

  Future<bool> loginOnClick(BuildContext context, String username, String password) async {
    log("NA9EX::LoginActivity::LoginClick()::Username: $username");
    var authenticationRequest = AuthenticationRequest(
      email: username,
      password: password,
    );
    log("NA9EX::LoginActivity::LoginClick()::Email: ${authenticationRequest.email}");
    try {
      var loginResponse = await ApiClient().login(context, authenticationRequest);
      if(loginResponse.status == SUCCESS) {
        if (!await isLoggedIn()) {
          await saveLoginDetails(username, password);
        }

        if (loginResponse.data?.role == 'ADMIN') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminHomePage()),
          );
          return true; // Return true on successful login
        }
      }
    } catch (e) {
      log("NA9EX::LoginActivity::LoginClick()::Login failed with exception: $e");
      return false; // Return false on login failure
    }
    return false; // Return false if login fails for other reasons
  }
}
