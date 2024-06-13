class TicketResponse {
  int id;
  String ticketNumber;
  int? maleCount;
  int? femaleCount;
  String route;
  int? pickupPointId;
  String? pickupPoint;
  int? dropPointId;
  String? dropPoint;
  DateTime date;
  String? status;
  String? description;
  int? customerId;
  DateTime createdAt;
  int issuerId;
  String msg;
  bool isChecked;

  TicketResponse({
    required this.id,
    required this.ticketNumber,
    required this.maleCount,
    required this.femaleCount,
    required this.route,
    required this.pickupPointId,
    required this.pickupPoint,
    required this.dropPointId,
    required this.dropPoint,
    required this.date,
    required this.status,
    required this.description,
    required this.customerId,
    required this.createdAt,
    required this.issuerId,
    required this.msg,
    this.isChecked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticketNumber': ticketNumber,
      'maleCount': maleCount,
      'femaleCount': femaleCount,
      'route': route,
      'pickupPointId': pickupPointId,
      'pickupPoint': pickupPoint,
      'dropPointId': dropPointId,
      'dropPoint': dropPoint,
      'date': date.toIso8601String(),
      'status': status,
      'description': description,
      'customerId': customerId,
      'createdAt': createdAt.toIso8601String(),
      'issuerId': issuerId,
      'msg': msg,
    };
  }

  factory TicketResponse.fromJson(Map<String, dynamic> json) {
    return TicketResponse(
      id: json['id'],
      ticketNumber: json['ticketNumber'],
      maleCount: json['maleCount'],
      femaleCount: json['femaleCount'],
      route: json['route'],
      pickupPointId: json['pickupPointId'],
      pickupPoint: json['pickupPoint'],
      dropPointId: json['dropPointId'],
      dropPoint: json['dropPoint'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      description: json['description'],
      customerId: json['customerId'],
      createdAt: DateTime.parse(json['createdAt']),
      issuerId: json['issuerId'],
      msg: json['msg'],
      isChecked: false,
    );
  }
}