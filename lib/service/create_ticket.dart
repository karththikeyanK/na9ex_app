import 'package:flutter/material.dart';
import 'package:na9ex_app/constants.dart';
import 'package:na9ex_app/service/api_client.dart';

import '../Model/ticket_request.dart';
import '../pages/admin/admin_home.dart';

class CreateTicketActivity {
  Future<void> createTicket(
      BuildContext context,
      String mobile_number,
      String customerName,
      String date,
      String toWhere,
      int male_count,
      int female_count,
      int pickupPointId,
      String pickup_point,
      int dropPointId,
      String drop_point,
      String description,
      int customerId) async {
    print(
        "CreateTicketActivity::createTicket()::Mobile Number: $mobile_number");

    TicketRequest ticketRequest = TicketRequest(
      ticketNumber: '',
      maleCount: male_count,
      femaleCount: female_count,
      mobileNumber: mobile_number,
      customerName: customerName,
      toWhere: toWhere,
      pickupPointId: pickupPointId,
      pickupPoint: pickup_point,
      dropPointId: dropPointId,
      dropPoint: drop_point,
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
        print("create_ticket::createTicket()::${ticketResponse.msg}");
        showConformationDialog(context, "WARNING", ticketResponse.msg, ticketResponse.id)
            .then((_) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AdminHomePage()),
          );
        });
      } else {
        print(
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
      print(
          "create_ticket::createTicket()::exception: $e");
      // showCustomAlert(context, "Sever Error",
      //     "Please wait for a moment & Try again.", "error");
    }
  }



}
