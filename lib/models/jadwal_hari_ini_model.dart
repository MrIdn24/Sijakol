class JadwalHariIniModel {
  final int? id;
  final String? guru_pengajar;
  final String? mata_pelajaran;
  final String? durasi;
  final String? waktu_mulai;
  final String? waktu_selesai;

  JadwalHariIniModel({
    this.id,
    this.guru_pengajar,
    this.mata_pelajaran,
    this.durasi,
    this.waktu_mulai,
    this.waktu_selesai,
  });

  factory JadwalHariIniModel.fromJson(Map<String, dynamic> json) {
    return JadwalHariIniModel(
      id: json['id'],
      guru_pengajar: json['guru_pengajar'],
      mata_pelajaran: json['mata_pelajaran'],
      durasi: json['durasi'],
      waktu_mulai: json['waktu_mulai'],
      waktu_selesai: json['waktu_selesai'],
    );
  }
}