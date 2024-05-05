class TicketRequest {
  String ticketNumber;
  int maleCount;
  int femaleCount;
  String mobileNumber;
  String customerName;
  String toWhere;
  int pickupPointId;
  String pickupPoint;
  int dropPointId;
  String dropPoint;
  DateTime date;
  String status;
  int userId;
  int customerId;
  String description;
  String msg;

  TicketRequest({
    required this.ticketNumber,
    required this.maleCount,
    required this.femaleCount,
    required this.mobileNumber,
    required this.customerName,
    required this.toWhere,
    required this.pickupPointId,
    required this.pickupPoint,
    required this.dropPointId,
    required this.dropPoint,
    required this.date,
    required this.status,
    required this.userId,
    required this.customerId,
    required this.msg,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'ticketNumber': ticketNumber,
      'maleCount': maleCount,
      'femaleCount': femaleCount,
      'mobileNumber': mobileNumber,
      'customerName': customerName,
      'toWhere': toWhere,
      'pickupPointId': pickupPointId,
      'pickupPoint': pickupPoint,
      'dropPointId': dropPointId,
      'dropPoint': dropPoint,
      'date': date.toIso8601String(),
      'status': status,
      'userId': userId,
      'customerId': customerId,
      'msg': msg,
      'description': description,
    };
  }

  factory TicketRequest.fromJson(Map<String, dynamic> json) {
    return TicketRequest(
      ticketNumber: json['ticketNumber'],
      maleCount: json['maleCount'],
      femaleCount: json['femaleCount'],
      mobileNumber: json['mobileNumber'],
      customerName: json['customerName'],
      toWhere: json['toWhere'],
      pickupPointId: json['pickupPointId'],
      pickupPoint: json['pickupPoint'],
      dropPointId: json['dropPointId'],
      dropPoint: json['dropPoint'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      userId: json['userId'],
      customerId: json['customerId'],
      msg: json['msg'],
      description: json['description'],
    );
  }
}