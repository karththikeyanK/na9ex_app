import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

const storage = FlutterSecureStorage();

Future<void> saveLoginDetails(String username, String password) async {
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
  String? username = await storage.read(key: 'username');
  return username != null;
}


Future<void> savePIN(String pin) async {
  String hashedPIN = sha256Hash(pin);
  await storage.write(key: 'pin', value: hashedPIN);
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
