import 'package:flutter/material.dart';
import 'package:na9ex_app/components/AdminNavBar.dart';
import 'package:na9ex_app/pages/pin_screen.dart';
import 'package:na9ex_app/service/view_ticket_activity.dart';

import 'create_ticket.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => AdminHomePageState();
}

class AdminHomePageState extends State<AdminHomePage> {
  ViewTicketActivity viewTicketActivity = ViewTicketActivity();
  int currentPageIndex = 0;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Exit'),
            content: const Text('Are you sure you want to logout or exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>const PinEntryScreen("Enter")),
                ),
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Home'),
          automaticallyImplyLeading: false,
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
                      MaterialPageRoute(
                          builder: (context) => const TicketForm()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF074173)),
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
                width: MediaQuery.of(context).size.width *
                    0.6, // 60% of screen width
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    viewTicketActivity.viewAllTicket(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF074173)),
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
        bottomNavigationBar: AdminNavBar(
          currentPageIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
