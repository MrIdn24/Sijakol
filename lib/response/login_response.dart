import 'dart:convert';

class LoginResponse {
  int code;
  String message;
  LoginDataUser? data;

  LoginResponse({
    required this.code,
    required this.message,
    this.data
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? LoginDataUser.fromJson(json['data']) : null
    );
  }
}

class LoginDataUser {
  final String name;
  final String email;
  final String token;
  LoginDataUser({required this.name, required this.email, required this.token});

  factory LoginDataUser.fromJson(Map<String, dynamic> json) {
    return LoginDataUser(
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }
}