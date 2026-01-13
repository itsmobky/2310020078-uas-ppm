class WaktuKuliah {
  final int id;
  final String hari;
  final String waktu;
  final String ruang;

  final String kodePupuk;
  final String namaPupuk;
  final int jumlah;

  WaktuKuliah({
    required this.id,
    required this.hari,
    required this.waktu,
    required this.ruang,
    required this.kodePupuk,
    required this.namaPupuk,
    required this.jumlah,
  });

  factory WaktuKuliah.fromJson(Map<String, dynamic> json) {
    return WaktuKuliah(
      id: json['id'],
      hari: json['hari'],
      waktu: json['id_waktu'],
      ruang: json['ruang'],

      kodePupuk: json['kode_pupuk'],
      namaPupuk: json['nama_pupuk'],
      jumlah: json['jumlah'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hari': hari,
      'id_waktu': waktu,
      'ruang': ruang,

      'kode_pupuk': kodePupuk,
      'nama_pupuk': namaPupuk,
      'jumlah': jumlah,
    };
  }
}
