class ProfilModel {
  final String id;
  final String nama;
  final String email;
  final String noHp;
  final String password;
  final String passwordHid;
  final String gambar;
  final String level;

  ProfilModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.noHp,
    required this.password,
    required this.passwordHid,
    required this.gambar,
    required this.level,
  });

  factory ProfilModel.fromJson(Map<String, dynamic> json) {
    return ProfilModel(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      noHp: json['noHp'],
      password: json['password'],
      passwordHid: json['passwordHid'],
      gambar: json['gambar'],
      level: json['level'],
    );
  }
}
