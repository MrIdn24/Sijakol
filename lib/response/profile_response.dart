
import 'package:sijakol/models/profile_model.dart';
import 'package:sijakol/response/base_response.dart';

class ProfileResponse extends SJKBaseResponse {
  ProfileResponse({
    required int code,
    required String message,
    ProfileModel? data,
  }) : super(code: code, message: message, data: data);

  factory ProfileResponse.fromJson(Map<String, dynamic> json, ProfileModel Function(dynamic) profileModel) {
    return ProfileResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? profileModel(json['data']) : null,
    );
  }
}