import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:na9ex_app/Model/ticket_details.dart';

class TicketsPage extends StatelessWidget {
  final List<TicketDetails> ticketsDetails;

  TicketsPage({super.key, required this.ticketsDetails}) {
    ticketsDetails.sort((a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
        backgroundColor: const Color(0xFF074173),
        foregroundColor: Colors.white,
      ),
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
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: ticket.pending != 0
                      ? const BorderSide(color: Colors.orange, width: 2)
                      : BorderSide.none,
                ),
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: ticket.pending == 0
                        ? const LinearGradient(
                      colors: [
                        Color(0xFFCD820C),
                        Color(0xFFFF7043),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                        : null,
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
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ticket.pending != 0 ? Colors.black : Colors.white,
                            ),
                          ),
                          Text(
                            ticket.route,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ticket.route == 'JAF->COL'
                                  ? const Color(0xFF880E4F)
                                  : const Color(0xFF0D274F),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Image(
                                image: AssetImage('assets/male.png'),
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${ticket.maleCount}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ticket.pending != 0 ? Colors.black : Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage('assets/female.png'),
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${ticket.femaleCount}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ticket.pending != 0 ? Colors.black : Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage('assets/mw.png'),
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${ticket.total}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ticket.pending != 0 ? Colors.black : Colors.white,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.warning,
                              color: Colors.red,
                            ),
                            Text(
                              '${ticket.pendingCount} PENDING',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}





