import 'package:na9ex_app/Model/ticket_response.dart';
import 'customer_response.dart';

class TicketAndCustomerResponse {
  final TicketResponse ticketResponse;
  final CustomerResponse customerResponse;

  TicketAndCustomerResponse({
    required this.ticketResponse,
    required this.customerResponse,
  });

  factory TicketAndCustomerResponse.fromJson(Map<String, dynamic> json) {
    return TicketAndCustomerResponse(
      ticketResponse: TicketResponse.fromJson(json['ticketResponse']),
      customerResponse: CustomerResponse.fromJson(json['customerResponse']),
    );
  }
}

