class JadwalHariIniResponse {
  int code;
  String message;
  List<JadwalData>? data;

  JadwalHariIniResponse({
    required this.code,
    required this.message,
    this.data
  });

  factory JadwalHariIniResponse.fromJson(Map<String, dynamic> json) {
    return JadwalHariIniResponse(
        code: json['code'],
        message: json['message'],
        data: json['data'] != null
            ? (json['data'] as List).map((item) => JadwalData.fromJson(item)).toList()
            : null,
    );
  }
}

class JadwalData {
  final int? id;
  final String? guru_pengajar;
  final String? mata_pelajaran;
  final String? durasi;
  final String? waktu_mulai;
  final String? waktu_selesai;

  JadwalData({
    this.id,
    this.guru_pengajar,
    this.mata_pelajaran,
    this.durasi,
    this.waktu_mulai,
    this.waktu_selesai,
  });

  factory JadwalData.fromJson(Map<String, dynamic> json) {
    return JadwalData(
      id: json['id'],
      guru_pengajar: json['guru_pengajar'],
      mata_pelajaran: json['mata_pelajaran'],
      durasi: json['durasi'],
      waktu_mulai: json['waktu_mulai'],
      waktu_selesai: json['waktu_selesai'],
    );
  }
}
