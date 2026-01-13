import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/waktukuliah.dart';

class PdfWaktuKuliah {
  static pw.Document generate(List<WaktuKuliah> data) {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'DATA WAKTU KULIAH & PUPUK',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 16),

              ...data.map(
                (w) => pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 10),
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Hari   : ${w.hari}'),
                      pw.Text('Waktu  : ${w.waktu}'),
                      pw.Text('Ruang  : ${w.ruang}'),
                      pw.SizedBox(height: 6),
                      pw.Text('Pupuk  : ${w.kodePupuk} - ${w.namaPupuk}'),
                      pw.Text('Jumlah : ${w.jumlah}'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }
}
