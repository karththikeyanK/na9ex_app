import 'package:flutter/material.dart';
import 'package:na9ex_app/Model/ticket_and_customer_response.dart';
import 'package:na9ex_app/Model/ticket_details.dart';
import 'package:na9ex_app/pages/admin/view_ticket.dart';
import 'package:na9ex_app/pages/admin/view_ticket_details.dart';
import 'package:na9ex_app/service/api_client.dart';

import 'package:intl/intl.dart';

class ViewTicketActivity {
  Future<void> viewAllTicket(BuildContext context) async {

    List<TicketDetails> ticket_details =  await ApiClient().getTicketDetails(context);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TicketsPage(ticketsDetails: ticket_details)),
    );
  }



  //view tickets by date and route then push to the view ticket details page
  Future<void> viewTicketByDateAndRoute(BuildContext context, String date, String route) async {
    List<TicketAndCustomerResponse> tickets =  await ApiClient().getTicketDetailsByDateAndRoute(context, date, route);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TicketsTable(
        tickets: tickets, title: route, date: DateFormat('MMMM dd, yyyy').format(DateTime.parse(date)).toString(),
    ),
    ));
  }
}
