

class LoginResponse {
  final String status;
  final String msg;
  final AuthData data;


  LoginResponse({required this.status, required this.msg, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      msg: json['msg'],
      data: AuthData.fromJson(json['data']),
    );
  }
}

class AuthData {
  final String token;
  final String role;
  final int id;

  AuthData({required this.token, required this.role, required this.id});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      token: json['token'],
      role: json['role'],
      id: json['id'],
    );
  }
}