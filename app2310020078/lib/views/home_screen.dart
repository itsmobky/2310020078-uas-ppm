import 'package:flutter/material.dart';
import 'matakuliah_view.dart';
import 'waktukuliah_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Akademik'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ✅ TOMBOL DATA MATA KULIAH (FIX)
            ElevatedButton.icon(
              icon: const Icon(Icons.book),
              label: const Text('Data Mata Kuliah'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MatakuliahView()),
                );
              },
            ),

            const SizedBox(height: 16),

            // ⏳ TOMBOL WAKTU KULIAH (NANTI)
            ElevatedButton.icon(
              icon: const Icon(Icons.schedule),
              label: const Text('Data Waktu Kuliah'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WaktuKuliahView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
