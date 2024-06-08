import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:na9ex_app/constants.dart';
import 'package:na9ex_app/service/api_client.dart';

import '../Model/ticket_request.dart';
import '../pages/admin/admin_home.dart';

class CreateTicketActivity {
  Future<void> createTicket(
      BuildContext context,
      String mobileNumber,
      String customerName,
      String date,
      String toWhere,
      int maleCount,
      int femaleCount,
      int pickupPointId,
      String pickupPoint,
      int dropPointId,
      String dropPoint,
      String description,
      int customerId) async {
    log(
        "CreateTicketActivity::createTicket()::Mobile Number: $mobileNumber");

    TicketRequest ticketRequest = TicketRequest(
      ticketNumber: '',
      maleCount: maleCount,
      femaleCount: femaleCount,
      mobileNumber: mobileNumber,
      customerName: customerName,
      toWhere: toWhere,
      pickupPointId: pickupPointId,
      pickupPoint: pickupPoint,
      dropPointId: dropPointId,
      dropPoint: dropPoint,
      date: DateTime.parse(date),
      status: '',
      userId: USER_ID,
      customerId: customerId,
      msg: '',
      description: description,
    );
    try {
      var ticketResponse =
          await ApiClient().createTicket(context, ticketRequest);
      if (ticketResponse.msg.isNotEmpty) {
        log("create_ticket::createTicket()::${ticketResponse.msg}");
        showConformationDialog(context, "WARNING", ticketResponse.msg, ticketResponse.id)
            .then((_) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AdminHomePage()),
          );
        });
      } else {
        log(
            "create_ticket::createTicket()::Ticket created successfully.");
        showCustomAlert(
                context, "SUCCESS", "Ticket created successfully.", "success")
            .then((_) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AdminHomePage()),
          );
        });
      }
    } catch (e) {
      log(
          "create_ticket::createTicket()::exception: $e");
      // showCustomAlert(context, "Sever Error",
      //     "Please wait for a moment & Try again.", "error");
    }
  }



}
