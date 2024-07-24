import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:na9ex_app/constants.dart';

const storage = FlutterSecureStorage();

Future<void> saveLoginDetails(String username, String password) async {
  log("NA9EX::LoginActivity::saveLoginDetails()::is called");
  await storage.write(key: 'username', value: username);
  await storage.write(key: 'password', value: password);
}

Future<Map<String, String?>> retrieveLoginDetails() async {
  String? username = await storage.read(key: 'username');
  String? password = await storage.read(key: 'password');
  return {'username': username, 'password': password};
}

Future<void> deleteLoginDetails() async {
  await storage.deleteAll();
}

// check if the user is logged in
Future<bool> isLoggedIn() async {
  String? username = await storage.read(key: 'pin');
  return username != null;
}


Future<void> savePIN(String pin,BuildContext context) async {
  String hashedPIN = sha256Hash(pin);
  await storage.write(key: 'pin', value: hashedPIN);
  await showCustomAlert(context,  "SUCCESS","PIN created successfully\nPlease Login Again","success");
}

Future<bool> hasPIN() async {
  String? storedPIN = await storage
      .read(key: 'pin');
  return storedPIN != null;
}

Future<bool> verifyPIN(String enteredPIN) async {
  String hashedEnteredPIN = sha256Hash(enteredPIN);
  String? storedPIN = await storage.read(key: 'pin');
  return hashedEnteredPIN == storedPIN;
}

String sha256Hash(String input) {
  var bytes = utf8.encode(input); // data being hashed
  var digest = sha256.convert(bytes);
  return digest.toString();
}
