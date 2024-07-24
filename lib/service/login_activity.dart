import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:na9ex_app/constants.dart';
import 'package:na9ex_app/pages/login_page.dart';
import 'package:na9ex_app/pages/pin_screen.dart';
import 'package:na9ex_app/service/utills/pin_service.dart';

import '../Model/login_request.dart';
import '../pages/admin/admin_home.dart';
import 'api_client.dart';

class LoginActivity {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
          setupPIN(context,username, password);
        }else if (loginResponse.data?.role == 'ADMIN') {
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

  Future<void> setupPIN(BuildContext context, String username, String password) async {
    saveLoginDetails(username, password);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PinEntryScreen("Create")));
  }

  void pinAction(BuildContext context, String pin,String mode) async {
    if(mode == "Create"){
      savePIN(pin,context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const PinEntryScreen("Enter")));
    }else if(mode == "Enter"){
      bool result = await verifyPIN(pin);
      if(result == true){
        Map<String, String?> loginDetails = await retrieveLoginDetails();
        loginOnClick(context,loginDetails['username']!,loginDetails['password']!);
      }else{
        showCustomAlert(context, "ERROR","Wrong Pin","error");
      }
    }
  }

  void forgotPin(BuildContext context) async {
    bool? result =await showCustomAlert(context, "WARNING","Are you sure you want to reset your PIN?","warning");
    if(result == true){
      await deleteLoginDetails();
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage()));
    }
  }

}
