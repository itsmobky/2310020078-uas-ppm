import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/waktukuliah.dart';

class WaktuKuliahService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/waktukuliah';

  // GET
  static Future<List<WaktuKuliah>> fetchData() async {
    final res = await http.get(Uri.parse(baseUrl));

    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => WaktuKuliah.fromJson(e)).toList();
    } else {
      throw Exception('Gagal load data waktu kuliah');
    }
  }

  // POST
  static Future<void> create(WaktuKuliah wk) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(wk.toJson()),
    );

    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception('Gagal tambah data');
    }
  }

  // PUT
  static Future<void> update(int id, WaktuKuliah wk) async {
    final res = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(wk.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception('Gagal update data');
    }
  }

  // DELETE
  static Future<void> delete(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));

    if (res.statusCode != 200) {
      throw Exception('Gagal hapus data');
    }
  }
}
