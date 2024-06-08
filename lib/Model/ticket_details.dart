class TicketDetails {
  final String date;
  final int maleCount;
  final int femaleCount;
  final int pending;
  final int pendingCount;
  final int total;
  final String route;

  TicketDetails({
    required this.date,
    required this.maleCount,
    required this.femaleCount,
    required this.pending,
    required this.pendingCount,
    required this.total,
    required this.route,
  });

  factory TicketDetails.fromJson(Map<String, dynamic> json) {
    return TicketDetails(
      date: json['date'],
      maleCount: json['maleCount'],
      femaleCount: json['femaleCount'],
      pending: json['pending'],
      pendingCount: json['pendingCount'],
      total: json['total'],
      route: json['route'],
    );
  }
}