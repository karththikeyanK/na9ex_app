import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:na9ex_app/Model/ticket_details.dart';
import 'package:na9ex_app/components/AdminNavBar.dart';
import 'package:na9ex_app/service/view_ticket_activity.dart';

class TicketsPage extends StatefulWidget {
  final List<TicketDetails> ticketsDetails;

  const TicketsPage({super.key, required this.ticketsDetails});

  @override
  TicketsPageState createState() => TicketsPageState();
}

class TicketsPageState extends State<TicketsPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    widget.ticketsDetails.sort((a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));

    var ticketsDetails = widget.ticketsDetails;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Tickets'),
      //   backgroundColor: const Color(0xFF074173),
      //   foregroundColor: Colors.white,
      // ),
      body: ListView.builder(
        itemCount: ticketsDetails.length,
        itemBuilder: (context, index) {
          final ticket = ticketsDetails[index];
          DateTime date = DateTime.parse(ticket.date);

          // Format the date to display "MM-Mon" (e.g., 06-Jun)
          String formattedDate = DateFormat('MMMM').format(date);

          // Group tickets by month
          List<TicketDetails> ticketsForMonth = ticketsDetails.where((t) =>
          DateTime.parse(t.date).month == date.month && DateTime.parse(t.date).year == date.year).toList();

          // Display the month header only for the first ticket of each month
          bool isFirstTicketOfMonth = index == 0 || date.month != DateTime.parse(ticketsDetails[index - 1].date).month;
          String dayOfWeek = DateFormat('EEE').format(date);

          bool route = ticket.route == 'JAF->COL';


          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isFirstTicketOfMonth) // Display month header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    formattedDate.replaceAll('-', ' '), // Replace "-" with " "
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              InkWell(
                onTap: () {
                  ViewTicketActivity().viewTicketByDateAndRoute(context, ticket.date, ticket.route);
                },
                child:Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: route
                          ? const LinearGradient(
                        colors: [
                          Color(0xFFCD820C),
                          Color(0xFFFF7043),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                          : const LinearGradient(
                        colors: [Color(0xFF074173), Color(0xFF507AA6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      color: ticket.pending != 0 ? Colors.white : null,
                    ),
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${DateFormat('dd').format(date)} - $dayOfWeek',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:Colors.white,
                              ),
                            ),
                            Text(
                              ticket.route,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ticket.route == 'JAF->COL'
                                    ? const Color(0xFFA9045D)
                                    : const Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                const Image(
                                  image: AssetImage('assets/man_w.png'),
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${ticket.maleCount}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Image(
                                  image: AssetImage('assets/female_w.png'),
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${ticket.femaleCount}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  // image: AssetImage('assets/mw_w.png'),
                                  width: 40,
                                  height: 30,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${ticket.total}',
                                  style: const TextStyle(
                                    fontSize: 52,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (ticket.pending != 0)
                          const SizedBox(height: 8),
                        if (ticket.pending != 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.warning,
                                color: Color(0xFFA20606),
                              ),
                              Text(
                                '${ticket.pendingCount} PENDING',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFA20606),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      bottomNavigationBar: AdminNavBar(
        currentPageIndex: currentPageIndex =1,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
