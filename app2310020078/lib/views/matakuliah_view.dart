import 'package:flutter/material.dart';
import '../models/matakuliah.dart';
import '../services/matakuliah_service.dart';
import 'form_matakuliah.dart';
import '../utils/pdf_matakuliah.dart';

class MatakuliahView extends StatefulWidget {
  const MatakuliahView({super.key});

  @override
  State<MatakuliahView> createState() => _MatakuliahViewState();
}

class _MatakuliahViewState extends State<MatakuliahView> {
  final service = MatakuliahService();
  late Future<List<Matakuliah>> future;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    setState(() {
      future = service.getAll();
    });
  }

  // ==========================
  // DIALOG EDIT (UPDATE)
  // ==========================
  void showEditDialog(Matakuliah mk) {
    final mataKuliahC = TextEditingController(text: mk.mataKuliah);
    final sksC = TextEditingController(text: mk.sks.toString());
    final jenisC = TextEditingController(text: mk.jenisPerkuliahan);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Mata Kuliah'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: mataKuliahC,
              decoration: const InputDecoration(labelText: 'Mata Kuliah'),
            ),
            TextField(
              controller: sksC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'SKS'),
            ),
            TextField(
              controller: jenisC,
              decoration: const InputDecoration(labelText: 'Jenis Perkuliahan'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              await service.update(
                mk.id,
                Matakuliah(
                  id: mk.id,
                  mataKuliah: mataKuliahC.text,
                  sks: int.parse(sksC.text),
                  jenisPerkuliahan: jenisC.text,
                ),
              );

              Navigator.pop(context);
              refresh();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mata Kuliah'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final data = await service.getAll();
              PdfMatakuliah.generate(data);
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormMatakuliah()),
          );
          refresh();
        },
        child: const Icon(Icons.add),
      ),

      body: FutureBuilder<List<Matakuliah>>(
        future: future,
        builder: (c, s) {
          if (s.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (s.hasError) {
            return Center(child: Text('${s.error}'));
          }

          final data = s.data!;
          if (data.isEmpty) {
            return const Center(child: Text('Belum ada data'));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) {
              final mk = data[i];
              return Card(
                child: ListTile(
                  title: Text(mk.mataKuliah),
                  subtitle: Text('SKS ${mk.sks} • ${mk.jenisPerkuliahan}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          showEditDialog(mk);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await service.delete(mk.id);
                          refresh();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
