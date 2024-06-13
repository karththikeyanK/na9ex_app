import 'package:flutter/material.dart';
import '../../Model/ticket_and_customer_response.dart';

class TicketsTable extends StatefulWidget {
  final List<TicketAndCustomerResponse> tickets;
  final String title;
  final String date;

  const TicketsTable({super.key, required this.tickets, required this.title, required this.date});

  @override
  TicketsTableState createState() => TicketsTableState();
}

class TicketsTableState extends State<TicketsTable> {
  List<TicketAndCustomerResponse> sortedTickets = [];

  @override
  void initState() {
    super.initState();
    sortedTickets = widget.tickets;
  }

  void sortTickets() {
    setState(() {
      sortedTickets.sort((a, b) => (b.ticketResponse.isChecked ? 1 : 0).compareTo(a.ticketResponse.isChecked ? 1 : 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<TicketAndCustomerResponse> validTickets = sortedTickets.where((ticket) => ticket.ticketResponse.status != "PENDING").toList();

    int totalMales = validTickets.fold(0, (sum, ticket) => sum + (ticket.ticketResponse.maleCount ?? 0));
    int totalFemales = validTickets.fold(0, (sum, ticket) => sum + (ticket.ticketResponse.femaleCount ?? 0));
    int totalSeats = totalMales + totalFemales;
    int pendingTickets = sortedTickets.where((ticket) => ticket.ticketResponse.status == "PENDING").length;
    int pendingMales = sortedTickets.where((ticket) => ticket.ticketResponse.status == "PENDING").fold(0, (sum, ticket) => sum + (ticket.ticketResponse.maleCount ?? 0));
    int pendingFemales = sortedTickets.where((ticket) => ticket.ticketResponse.status == "PENDING").fold(0, (sum, ticket) => sum + (ticket.ticketResponse.femaleCount ?? 0));
    int pendingSeats = (pendingMales ?? 0) + (pendingFemales ?? 0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
        backgroundColor: const Color(0xFF074173),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: const LinearGradient(
                colors: [Color(0xFF074173), Color(0xFF507AA6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.date,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          '$totalMales',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                          '$totalFemales',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                          '$totalSeats',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                if (pendingTickets > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.warning,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'PENDING: $pendingMales M + $pendingFemales F = $pendingSeats',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          ...sortedTickets.map((ticket) {
            Color statusColor;
            if (ticket.ticketResponse.status == "CONFIRMED") {
              statusColor = Colors.green[900]!;
            } else if (ticket.ticketResponse.status == "PENDING") {
              statusColor = Colors.red;
            } else {
              statusColor = !ticket.ticketResponse.isChecked ? Colors.black : Colors.white;
            }

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: !ticket.ticketResponse.isChecked
                    ? const BorderSide(color: Colors.orange, width: 2)
                    : BorderSide.none,
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: !ticket.ticketResponse.isChecked
                      ? null
                      : const LinearGradient(
                    colors: [
                      Color(0xFFCD820C),
                      Color(0xFFFF7043),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  color: !ticket.ticketResponse.isChecked ? Colors.white : null,
                ),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ticket.customerResponse.name.isEmpty ? 'No Name' : ticket.customerResponse.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: !ticket.ticketResponse.isChecked ? Colors.black : Colors.white,
                          ),
                        ),
                        Checkbox(
                          value: ticket.ticketResponse.isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              ticket.ticketResponse.isChecked = value!;
                              sortTickets();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      ticket.customerResponse.mobile,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: !ticket.ticketResponse.isChecked ? Colors.black : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
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
                              '${ticket.ticketResponse.maleCount}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: !ticket.ticketResponse.isChecked ? Colors.black : Colors.white,
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
                              '${ticket.ticketResponse.femaleCount}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: !ticket.ticketResponse.isChecked ? Colors.black : Colors.white,
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
                              '${(ticket.ticketResponse.maleCount ?? 0) + (ticket.ticketResponse.femaleCount ?? 0)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: !ticket.ticketResponse.isChecked ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: !ticket.ticketResponse.isChecked ? Colors.black : Colors.white),
                        const SizedBox(width: 8.0),
                        Text(
                          'Pickup Point: ${ticket.ticketResponse.pickupPoint ?? ''}',
                          style: TextStyle(
                            color: !ticket.ticketResponse.isChecked ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_off, color: !ticket.ticketResponse.isChecked ? Colors.black : Colors.white),
                        const SizedBox(width: 8.0),
                        Text(
                          'Drop Point: ${ticket.ticketResponse.dropPoint ?? ''}',
                          style: TextStyle(
                            color: !ticket.ticketResponse.isChecked ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.description, color: !ticket.ticketResponse.isChecked ? Colors.black : Colors.white),
                        const SizedBox(width: 8.0),
                        Text(
                          ticket.ticketResponse.description ?? '',
                          style: TextStyle(
                            color: !ticket.ticketResponse.isChecked ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (ticket.ticketResponse.status == "PENDING")
                          const Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'PENDING',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        if (ticket.ticketResponse.status != "PENDING")
                          Text(
                            ticket.ticketResponse.status ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
