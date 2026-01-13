class Matakuliah {
  final int id;
  final String mataKuliah;
  final int sks;
  final String jenisPerkuliahan;

  Matakuliah({
    required this.id,
    required this.mataKuliah,
    required this.sks,
    required this.jenisPerkuliahan,
  });

  factory Matakuliah.fromJson(Map<String, dynamic> json) {
    return Matakuliah(
      id: json['id'],
      mataKuliah: json['mata_kuliah'],
      sks: json['sks'],
      jenisPerkuliahan: json['jenis_perkuliahan'],
    );
  }

  Map<String, dynamic> toJson() => {
    'mata_kuliah': mataKuliah,
    'sks': sks,
    'jenis_perkuliahan': jenisPerkuliahan,
  };
}
