import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/matakuliah.dart';

class MatakuliahService {
  final String baseUrl = 'http://127.0.0.1:8000/api/matakuliah';

  Future<List<Matakuliah>> getAll() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => Matakuliah.fromJson(e)).toList();
    }
    throw Exception('Gagal load data');
  }

  Future<void> create(Matakuliah mk) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mk.toJson()),
    );
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception('Gagal tambah data');
    }
  }

  Future<void> update(int id, Matakuliah mk) async {
    final res = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mk.toJson()),
    );
    if (res.statusCode != 200) {
      throw Exception('Gagal update data');
    }
  }

  Future<void> delete(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));
    if (res.statusCode != 200) {
      throw Exception('Gagal hapus data');
    }
  }
}
