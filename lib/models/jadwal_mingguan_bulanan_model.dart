class JadwalMingguanBulananModel {
  int? minggu;
  List<JadwalData>? jadwalData;

  JadwalMingguanBulananModel({this.minggu, this.jadwalData});

  factory JadwalMingguanBulananModel.fromJson(Map<String, dynamic> json) {
    return JadwalMingguanBulananModel(
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