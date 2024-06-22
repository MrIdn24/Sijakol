
class ProfileModel {
  final String? nama;
  final String? email;
  final String? kelas;
  final String? profile_picture_name;

  ProfileModel({
    this.nama,
    this.email,
    this.kelas,
    this.profile_picture_name
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      nama: json['nama'],
      email: json['email'],
      kelas: json['kelas'],
      profile_picture_name: json['profile_picture_name'],
    );
  }
}