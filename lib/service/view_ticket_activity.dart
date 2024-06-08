import 'package:flutter/material.dart';
import 'package:na9ex_app/Model/ticket_details.dart';
import 'package:na9ex_app/pages/admin/view_ticket.dart';
import 'package:na9ex_app/service/api_client.dart';

class ViewTicketActivity {
  Future<void> viewAllTicket(BuildContext context) async {

    List<TicketDetails> ticket_details =  await ApiClient().getTicketDetails(context);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TicketsPage(ticketsDetails: ticket_details)),
    );
  }
}
