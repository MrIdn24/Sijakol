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
  final String kelas_name;
  final int kelas_id;
  final String profile_picture_url;

  LoginDataUser({
    required this.name,
    required this.email,
    required this.token,
    required this.kelas_name,
    required this.kelas_id,
    required this.profile_picture_url
  });

  factory LoginDataUser.fromJson(Map<String, dynamic> json) {
    return LoginDataUser(
      name: json['name'],
      email: json['email'],
      token: json['token'],
      kelas_name: json['kelas_name'],
      kelas_id: json['kelas_id'],
      profile_picture_url: json['profile_picture_name']
    );
  }
}