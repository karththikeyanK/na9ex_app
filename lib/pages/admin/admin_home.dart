import 'package:flutter/material.dart';
import 'package:na9ex_app/service/view_ticket_activity.dart';

import 'create_ticket.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  ViewTicketActivity viewTicketActivity = ViewTicketActivity();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the Admin Home Page!'),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.6, // 60% of screen width
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TicketForm()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF074173)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Color(0xFF074173))),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                  ),
                ),
                child: const Text(
                  'Create Ticket',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6, // 60% of screen width
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  viewTicketActivity.viewAllTicket(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF074173)),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Color(0xFF074173))),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                  ),
                ),
                child: const Text(
                  'View Tickets',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
