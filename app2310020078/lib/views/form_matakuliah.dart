import 'package:flutter/material.dart';
import '../models/matakuliah.dart';
import '../services/matakuliah_service.dart';

class FormMatakuliah extends StatefulWidget {
  final Matakuliah? data;
  const FormMatakuliah({super.key, this.data});

  @override
  State<FormMatakuliah> createState() => _FormMatakuliahState();
}

class _FormMatakuliahState extends State<FormMatakuliah> {
  final _formKey = GlobalKey<FormState>();
  final service = MatakuliahService();

  final _nama = TextEditingController();
  final _sks = TextEditingController();
  final _jenis = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      _nama.text = widget.data!.mataKuliah;
      _sks.text = widget.data!.sks.toString();
      _jenis.text = widget.data!.jenisPerkuliahan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Mata Kuliah')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nama,
                decoration: const InputDecoration(labelText: 'Nama MK'),
              ),
              TextFormField(
                controller: _sks,
                decoration: const InputDecoration(labelText: 'SKS'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _jenis,
                decoration: const InputDecoration(labelText: 'Jenis'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final mk = Matakuliah(
                    id: widget.data?.id ?? 0,
                    mataKuliah: _nama.text,
                    sks: int.parse(_sks.text),
                    jenisPerkuliahan: _jenis.text,
                  );
                  if (widget.data == null) {
                    await service.create(mk);
                  } else {
                    await service.update(widget.data!.id, mk);
                  }
                  Navigator.pop(context);
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
