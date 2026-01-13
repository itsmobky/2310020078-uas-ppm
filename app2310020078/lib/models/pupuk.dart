class Pupuk {
  final int id;
  final String kode;
  final String nama;
  final String jumlah;

  Pupuk({
    required this.id,
    required this.kode,
    required this.nama,
    required this.jumlah,
  });

  factory Pupuk.fromJson(Map<String, dynamic> json) {
    return Pupuk(
      id: json['id'],
      kode: json['kode'],
      nama: json['nama'],
      jumlah: json['jumlah'],
    );
  }

  Map<String, dynamic> toJson() => {
    'kode': kode,
    'nama': nama,
    'jumlah': jumlah,
  };
}
