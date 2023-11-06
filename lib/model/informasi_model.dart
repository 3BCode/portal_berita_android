class InformasiModel {
  final String id;
  final String judul;
  final String deskripsi;
  final String gambar;
  final String tanggal;
  final String isi;

  InformasiModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.gambar,
    required this.tanggal,
    required this.isi,
  });

  factory InformasiModel.fromJson(Map<String, dynamic> json) {
    return InformasiModel(
      id: json['id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar'],
      tanggal: json['tanggal'],
      isi: json['isi'],
    );
  }
}
