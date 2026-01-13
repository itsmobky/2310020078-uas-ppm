import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/matakuliah.dart';

class PdfMatakuliah {
  static Future<void> generate(List<Matakuliah> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Data Mata Kuliah',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 12),

              ...data.map(
                (m) => pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 6),
                  child: pw.Text(
                    '${m.mataKuliah} | ${m.sks} SKS | ${m.jenisPerkuliahan}',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}
