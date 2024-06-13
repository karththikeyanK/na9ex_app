class CustomerResponse {
  final int id;
  final String name;
  final String mobile;

  CustomerResponse({
    required this.id,
    required this.name,
    required this.mobile,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    return CustomerResponse(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
    );
  }
}