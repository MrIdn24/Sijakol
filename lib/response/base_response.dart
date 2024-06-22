class SJKBaseResponse<T> {
  int code;
  String message;
  T? data;

  SJKBaseResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory SJKBaseResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return SJKBaseResponse<T>(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  @override
  String toString() {
    return 'BaseResponse(code: $code, message: $message, data: $data)';
  }
}