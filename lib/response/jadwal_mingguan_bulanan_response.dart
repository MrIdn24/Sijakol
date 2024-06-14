class JadwalMingguanBulananResponse {
  int code;
  String message;
  List<Data>? data;

  JadwalMingguanBulananResponse({
    required this.code,
    required this.message,
    this.data
  });

  factory JadwalMingguanBulananResponse.fromJson(Map<String, dynamic> json) {
    return JadwalMingguanBulananResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((item) => Data.fromJson(item)).toList()
          : null,
    );
  }
}

class Data {
  int? minggu;
  List<JadwalData>? jadwalData;

  Data({this.minggu, this.jadwalData});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      minggu: json['minggu'],
      jadwalData: json['jadwal'] != null
          ? (json['jadwal'] as List).map((item) => JadwalData.fromJson(item)).toList()
          : null,
    );
  }
}

class JadwalData {
  String hari;
  String tanggal;
  List<InnerJadwalData>? jadwal;

  JadwalData({required this.hari, required this.tanggal, this.jadwal});

  factory JadwalData.fromJson(Map<String, dynamic> json) {
    return JadwalData(
      hari: json['hari'],
      tanggal: json['tanggal'],
      jadwal: json['jadwal'] != null
          ? (json['jadwal'] as List).map((item) => InnerJadwalData.fromJson(item)).toList()
          : null,
    );
  }
}

class InnerJadwalData {
  final int? id;
  final String? guru_pengajar;
  final String? mata_pelajaran;
  final String? durasi;
  final String? waktu_mulai;
  final String? waktu_selesai;

  InnerJadwalData({
    this.id,
    this.guru_pengajar,
    this.mata_pelajaran,
    this.durasi,
    this.waktu_mulai,
    this.waktu_selesai,
  });

  factory InnerJadwalData.fromJson(Map<String, dynamic> json) {
    return InnerJadwalData(
      id: json['id'],
      guru_pengajar: json['guru'],
      mata_pelajaran: json['mata_pelajaran'],
      durasi: json['durasi'],
      waktu_mulai: json['waktu_mulai'],
      waktu_selesai: json['waktu_selesai'],
    );
  }
}