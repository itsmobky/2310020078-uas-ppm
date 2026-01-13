import 'package:flutter/material.dart';
import '../models/waktukuliah.dart';
import '../services/waktukuliah_service.dart';
import 'package:printing/printing.dart';
import '../utils/pdf_waktukuliah.dart';

class WaktuKuliahView extends StatefulWidget {
  const WaktuKuliahView({super.key});

  @override
  State<WaktuKuliahView> createState() => _WaktuKuliahViewState();
}

class _WaktuKuliahViewState extends State<WaktuKuliahView> {
  final hariC = TextEditingController();
  final waktuC = TextEditingController();
  final ruangC = TextEditingController();

  final kodePupukC = TextEditingController();
  final namaPupukC = TextEditingController();
  final jumlahC = TextEditingController();

  late Future<List<WaktuKuliah>> future;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    setState(() {
      future = WaktuKuliahService.fetchData();
    });
  }

  // DIALOG TAMBAH DATA
  void showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Waktu Kuliah'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: hariC,
                decoration: const InputDecoration(labelText: 'Hari'),
              ),
              TextField(
                controller: waktuC,
                decoration: const InputDecoration(labelText: 'Waktu'),
              ),
              TextField(
                controller: ruangC,
                decoration: const InputDecoration(labelText: 'Ruang'),
              ),

              const SizedBox(height: 8),

              // 🔽 FIELD PUPUK
              TextField(
                controller: kodePupukC,
                decoration: const InputDecoration(labelText: 'Kode Pupuk'),
              ),
              TextField(
                controller: namaPupukC,
                decoration: const InputDecoration(labelText: 'Nama Pupuk'),
              ),
              TextField(
                controller: jumlahC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Jumlah'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            child: const Text('Simpan'),
            onPressed: () async {
              await WaktuKuliahService.create(
                WaktuKuliah(
                  id: 0,
                  hari: hariC.text,
                  waktu: waktuC.text,
                  ruang: ruangC.text,

                  // 🔽 DATA PUPUK
                  kodePupuk: kodePupukC.text,
                  namaPupuk: namaPupukC.text,
                  jumlah: int.parse(jumlahC.text),
                ),
              );

              // clear semua input
              hariC.clear();
              waktuC.clear();
              ruangC.clear();
              kodePupukC.clear();
              namaPupukC.clear();
              jumlahC.clear();

              Navigator.pop(context);
              refresh();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Waktu Kuliah'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final data = await future;

              final pdf = PdfWaktuKuliah.generate(data);

              await Printing.layoutPdf(onLayout: (format) => pdf.save());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<WaktuKuliah>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(child: Text('Belum ada data'));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final w = data[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(w.hari),
                  subtitle: Text(
                    '${w.waktu} | ${w.ruang}\n'
                    'Pupuk: ${w.kodePupuk} - ${w.namaPupuk} (${w.jumlah})',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await WaktuKuliahService.delete(w.id);
                      refresh();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: showAddDialog,
      ),
    );
  }
}
