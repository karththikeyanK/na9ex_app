import 'dart:convert';
import 'dart:developer';
import 'dart:async';
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

  Future<http.Response> postRequest(BuildContext context,String url, Map<String, dynamic> body) async {
    log("ApiClient::postRequest()::url: $url");
    showLoading(context);
    var response =  await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
      body: jsonEncode(body),
    );
    hideLoading(context);
    return response;
  }

  static Future<http.Response> get(String url) async {
    return client.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<LoginResponse> login(BuildContext context, AuthenticationRequest authenticationRequest) async {
    var url = '$BASE_URL/auth/authenticate';
    log(url);
    try {
      showLoading(context);
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(authenticationRequest.toJson()),
      ).timeout(const Duration(seconds: 5));
      hideLoading(context);
      await Future.delayed(const Duration(milliseconds: 500));
      var data = jsonDecode(response.body);
      if (response.statusCode == OK && data != null) {
        var loginResponse = LoginResponse.fromJson(data);
        if (loginResponse.status == 'SUCCESS' && loginResponse.data != null) {
          ApiClient.setToken(loginResponse.data!.token);
          USER_ID = loginResponse.data!.id;
          return loginResponse;
        }
      }
      if (response.statusCode == BAD_REQUEST && data['status'] == 'ERROR' &&
          data['msg'] == 'Invalid credentials') {
        await showCustomAlert(context, "Invalid Credentials",
            "Please check the username and password", "error");
        throw Exception('Invalid credentials');
      } else {
        await showCustomAlert(context, "Login Failed", "Try Again!", "error");
        throw Exception('Login failed');
      }
      // } on TimeoutException {
      //   hideLoading(context);
      //   await showCustomAlert(context, "Login Failed", "Timeout/Try Again!", "error");
      //   throw Exception('Login failed');
      // }
    }catch(e){
      if(e is TimeoutException){
        log("ApiClient::Login::TimeoutException::${e.message}");
        hideLoading(context);
        await showCustomAlert(context, "Login Failed", "Timeout/Try Again!", "error");
        throw Exception('Login failed');
      } else if(e is http.ClientException){
        log("ApiClient::Login::ClientException::${e.message}");
        hideLoading(context);
        await showCustomAlert(context, "Login Failed", "Network Error..Try Again!", "error");
        throw Exception('Login failed');
      } else {
        log("ApiClient::Login::Exception::${e.toString()}");
        throw Exception('Login failed');
      }
    }
  }


  Future<TicketResponse> createTicket(BuildContext context, TicketRequest ticketRequest) async {
    log("ApiClient::createTicket()::start");
    var url = '$BASE_URL/ticket/create';
    log(url);
    showLoading(context);
    var response = await client.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(ticketRequest.toJson()),
    ).timeout(Duration(seconds: 5));
    hideLoading(context);
    await Future.delayed(const Duration(seconds: 1));

    log("Response Status code ${response.statusCode}");
    if (response.statusCode == OK) {
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
      if (response.statusCode == OK) {
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
    if (response.statusCode == OK) {
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
    if (response.statusCode == OK) {
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
    if (response.statusCode == OK) {
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

  checkNetwork() {
    return true;
  }



}