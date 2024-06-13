import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:na9ex_app/Model/login_request.dart';
import 'package:na9ex_app/Model/ticket_and_customer_response.dart';
import 'package:na9ex_app/Model/ticket_request.dart';
import 'package:na9ex_app/Model/ticket_details.dart';
import 'package:na9ex_app/constants.dart';

import '../Model/login_response.dart';
import '../Model/ticket_response.dart';

class ApiClient {
  static final client = http.Client();
  static String? token;

  static void setToken(String value) {
    token = value;
    log("ApiClient::setToken()::Token setting successful");
  }

  Future<http.Response> postRequest(String url, Map<String, dynamic> body) async {
    return await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> get(String url) async {
    return client.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<LoginResponse> login(BuildContext context, AuthenticationRequest authenticationRequest) async {
    log("ApiClient::login()::start");
    var url = '$BASE_URL/auth/authenticate';
    log(url);
    try{
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(authenticationRequest.toJson()),
      );
      var data = jsonDecode(response.body);
      if(response.body!=null){
        var loginResponse = LoginResponse.fromJson(data);
        if (loginResponse.status == 'SUCCESS' && loginResponse.data != null) {
          log("ApiClient::login()::Login successful with user id: ${loginResponse.data!.id}");
          ApiClient.setToken(loginResponse.data!.token);
          USER_ID= loginResponse.data!.id;
          return loginResponse;
        } else if(loginResponse.status == 'ERROR' && loginResponse.msg == 'Invalid credentials'){
          log("ApiClient::login()::Login failed");
          showCustomAlert(context, "Login Failed", "Check your user name or password and try again.", "error");
          throw Exception('Invalid credentials');
        } else {
          log("ApiClient::login()::Login failed");
          showCustomAlert(context, "Login Failed", "Try again.", "error");
          throw Exception('Login failed');
        }
      }else{
        log("ApiClient::login()::Network Error");
        showCustomAlert(context, "Login Failed", "Network Error", "error");
        throw Exception('Network Error');
      }
    }catch(e){
      log("ApiClient::login()::Exception::${e.toString()}");
      if(e is http.ClientException){
        showCustomAlert(context, "Login Failed", "Network Error", "error");
        log("ApiClient::login()::ClientException::${e.message}");
      }else if(e.toString()=="Invalid credentials"){
        throw Exception('Invalid credentials');
      }
      throw Exception('Network Error');
    }


  }

  Future<TicketResponse> createTicket(BuildContext context, TicketRequest ticketRequest) async {
    log("ApiClient::createTicket()::start");
    var url = '$BASE_URL/ticket/create';
    log(url);
    var response = await client.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(ticketRequest.toJson()),
    );
    log("Response Status code ${response.statusCode}");
    if (response.statusCode == 200) {
      log("ApiClient::creteTicket():: getting response success");
      var data = jsonDecode(response.body);
      var ticketResponse = TicketResponse.fromJson(data['data']); // Fixed line
      if (data['status'] == 'SUCCESS') { // Use data instead of data.status
        log("ApiClient::createTicket()::Ticket created successfully");
        return ticketResponse;
      } else {
        log("ApiClient::createTicket()::Ticket creation failed");
        showCustomAlert(context, "Ticket Creation Failed", "Check your ticket details and try again.", "error");
        throw Exception('Ticket creation failed');
      }
    } else {
      log("ApiClient::createTicket()::Network/Server error");
      showCustomAlert(context, "Network/Server Error", "Check your internet connection and try again.", "error");
      throw Exception('Network error');
    }
  }


  Future<bool> updateStatus(BuildContext context, int ticketId, int status) async {
    log("ApiClient::updateStatus()::start");
    try {
      var url = '$BASE_URL/ticket/updateStatus/$ticketId/$status';
      log(url);
      var response = await client.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      log("Response Status code ${response.statusCode}");
      if (response.statusCode == 200) {
        log("ApiClient::updateStatus():: getting response success");
        var data = jsonDecode(response.body);
        if (data['status'] == 'SUCCESS') {
          log("ApiClient::updateStatus()::Ticket Update Status successfully");
          return true;
        } else {
          log("ApiClient::updateStatus()::Ticket cancellation failed");
          showCustomAlert(context, "Ticket Update Status Failed", "Check your ticket details and try again.", "error");
          throw Exception('Ticket Update Status failed');
        }
      } else {
        log("ApiClient::updateStatus()::Network/Server error");
        showCustomAlert(context, "Network/Server Error", "Check your internet connection and try again.", "error");
        throw Exception('Network error');
      }
    } catch(e) {
      if(e is http.ClientException){
        log("ApiClient::UpdateStatus::ClientException::${e.message}");
      } else {
        log("ApiClient::UpdateStatus::Exception::${e.toString()}");
      }
      return false; // Return false when an exception is caught
    }
  }

  Future<bool> deleteTicket(BuildContext context, int ticketId) async {
    log("ApiClient::deleteTicket()::start");
    var url = '$BASE_URL/ticket/delete/$ticketId';
    log(url);
    var response = await client.delete(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    log("Response Status code ${response.statusCode}");
    if (response.statusCode == 200) {
      log("ApiClient::deleteTicket():: getting response success");
      var data = jsonDecode(response.body);
      if (data['status'] == 'SUCCESS') {
        log("ApiClient::deleteTicket()::Ticket deleted successfully");
        return true;
      } else {
        log("ApiClient::deleteTicket()::Ticket deletion failed");
        showCustomAlert(context, "Ticket Deletion Failed", "Check your ticket details and try again.", "error");
        throw Exception('Ticket deletion failed');
      }
    } else {
      log("ApiClient::deleteTicket()::Network/Server error");
      showCustomAlert(context, "Network/Server Error", "Check your internet connection and try again.", "error");
      throw Exception('Network error');
    }
  }


  Future<List<TicketDetails>> getTicketDetails(BuildContext context) async {
    log("ApiClient::getTicketDetails()::start");
    var url = '$BASE_URL/ticket/getTicketDetails';
    log(url);
    var response = await client.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    log("Response Status code ${response.statusCode}");
    if (response.statusCode == 200) {
      log("ApiClient::getTicketDetails():: getting response success");
      var data = jsonDecode(response.body);
      var ticketList = data['data'] as List;
      List<TicketDetails> tickets = ticketList.map((i) => TicketDetails.fromJson(i)).toList();
      return tickets;
    } else {
      log("ApiClient::getTicketDetails()::Network/Server error");
      showCustomAlert(context, "Network/Server Error", "Check your internet connection and try again.", "error");
      throw Exception('Network error');
    }
  }



  //http://localhost:8080/api/v1/ticket/getAllByDateAndRoute/2024-06-26/JAF->COL
  Future<List<TicketAndCustomerResponse>> getTicketDetailsByDateAndRoute(BuildContext context, String date, String route) async {
    log("ApiClient::getTicketDetailsByDateAndRoute()::start");
    var url = '$BASE_URL/ticket/getAllByDateAndRoute/$date/$route';
    var response = await client.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    log("Response Status code ${response.statusCode}");
    if (response.statusCode == 200) {
      log("ApiClient::getTicketDetailsByDateAndRoute():: getting response success");
      var data = jsonDecode(response.body);
      var ticketList = data['data'] as List;
      List<TicketAndCustomerResponse> tickets = ticketList.map((i) => TicketAndCustomerResponse.fromJson(i)).toList();
      return tickets;
    } else {
      log("ApiClient::getTicketDetailsByDateAndRoute()::Network/Server error");
      showCustomAlert(context, "Network/Server Error", "Check your internet connection and try again.", "error");
      throw Exception('Network error');
    }
  }



}