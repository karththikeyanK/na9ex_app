import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:na9ex_app/Model/login_request.dart';
import 'package:na9ex_app/Model/ticket_request.dart';
import 'package:na9ex_app/constants.dart';

import '../Model/login_response.dart';
import '../Model/ticket_response.dart';

class ApiClient {
  static final client = http.Client();
  static String? token;

  static void setToken(String value) {
    token = value;
    print("ApiClient::setToken()::Token setting successful");
  }


  static Future<http.Response> get(String url) async {
    return client.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<LoginResponse> login(BuildContext context, AuthenticationRequest authenticationRequest) async {
    print("ApiClient::login()::start");
    var url = '$BASE_URL/auth/authenticate';
    print(url);
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(authenticationRequest.toJson()),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var loginResponse = LoginResponse.fromJson(data);
      if (loginResponse.status == 'SUCCESS') {
        print("ApiClient::login()::Login successful with user id: ${loginResponse.data.id}");
        ApiClient.setToken(loginResponse.data.token);
        USER_ID= loginResponse.data.id;
        return loginResponse;
      } else if(loginResponse.msg == 'Bad credentials'){
        print("ApiClient::login()::Login failed");
        showCustomAlert(context, "Login Failed", "Check your credentials and try again.", "error");
        throw Exception('Login failed');
      }else{
        print("ApiClient::login()::Login failed");
        showCustomAlert(context, "Login Failed", "Try again.", "error");
        throw Exception('Login failed');
      }
    } else {
      print("ApiClient::login()::Network/Server error");
      showCustomAlert(context, "Network/Server Error", "Check your internet connection and try again.", "error");
      throw Exception('Network error');
    }
  }


  Future<TicketResponse> createTicket(BuildContext context, TicketRequest ticketRequest) async {
    print("ApiClient::createTicket()::start");
    var url = '$BASE_URL/ticket/create';
    print(url);
    var response = await client.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(ticketRequest.toJson()),
    );
    print("Response Status code ${response.statusCode}");
    if (response.statusCode == 200) {
      print("ApiClient::creteTicket():: getting response success");
      var data = jsonDecode(response.body);
      var ticketResponse = TicketResponse.fromJson(data['data']); // Fixed line
      if (data['status'] == 'SUCCESS') { // Use data instead of data.status
        print("ApiClient::createTicket()::Ticket created successfully");
        return ticketResponse;
      } else {
        print("ApiClient::createTicket()::Ticket creation failed");
        showCustomAlert(context, "Ticket Creation Failed", "Check your ticket details and try again.", "error");
        throw Exception('Ticket creation failed');
      }
    } else {
      print("ApiClient::createTicket()::Network/Server error");
      showCustomAlert(context, "Network/Server Error", "Check your internet connection and try again.", "error");
      throw Exception('Network error');
    }
  }


  Future<bool> updateStatus(BuildContext context, int ticketId, int status) async {
    print("ApiClient::updateStatus()::start");
    ticketId =33;
    var url = '$BASE_URL/updateStatus/$ticketId/$status';
    print(url);
    var response = await client.put(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    print("Response Status code ${response.statusCode}");
    if (response.statusCode == 200) {
      print("ApiClient::updateStatus():: getting response success");
      var data = jsonDecode(response.body);
      if (data['status'] == 'SUCCESS') {
        print("ApiClient::updateStatus()::Ticket Update Status successfully");
        return true;
      } else {
        print("ApiClient::updateStatus()::Ticket cancellation failed");
        showCustomAlert(context, "Ticket Update Status Failed", "Check your ticket details and try again.", "error");
        throw Exception('Ticket Update Status failed');
      }
    } else {
      print("ApiClient::updateStatus()::Network/Server error");
      showCustomAlert(context, "Network/Server Error", "Check your internet connection and try again.", "error");
      throw Exception('Network error');
    }
  }


  Future<bool> deleteTicket(BuildContext context, int ticketId) async {
    print("ApiClient::deleteTicket()::start");
    var url = '$BASE_URL/delete/$ticketId';
    print(url);
    var response = await client.delete(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    print("Response Status code ${response.statusCode}");
    if (response.statusCode == 200) {
      print("ApiClient::deleteTicket():: getting response success");
      var data = jsonDecode(response.body);
      if (data['status'] == 'SUCCESS') {
        print("ApiClient::deleteTicket()::Ticket deleted successfully");
        return true;
      } else {
        print("ApiClient::deleteTicket()::Ticket deletion failed");
        showCustomAlert(context, "Ticket Deletion Failed", "Check your ticket details and try again.", "error");
        throw Exception('Ticket deletion failed');
      }
    } else {
      print("ApiClient::deleteTicket()::Network/Server error");
      showCustomAlert(context, "Network/Server Error", "Check your internet connection and try again.", "error");
      throw Exception('Network error');
    }
  }






}