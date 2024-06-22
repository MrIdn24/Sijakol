import 'base_response.dart';

class JadwalResponse<T> extends SJKBaseResponse<T> {
  JadwalResponse({
    required int code,
    required String message,
    T? data,
  }) : super(code: code, message: message, data: data);

  factory JadwalResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return JadwalResponse<T>(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}