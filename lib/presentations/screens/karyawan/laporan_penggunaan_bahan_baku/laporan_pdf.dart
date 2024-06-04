import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:frontend_mobile/data/model/pengunaan_bahan_baku.dart';

Future<void> generatePdf(List<PenggunaanBahanBaku> data, String periode, BuildContext context) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageTheme: const pw.PageTheme(
        pageFormat: PdfPageFormat.a4
      ),
      footer: (pw.Context context) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Text('Atma Kitchen'),
            pw.Text('Jl. Centralpark No. 10 Yogyakarta')
          ]
        );
      },
      build: (pw.Context context){
        return [
          pw.Text('Atma Kitchen',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold
            )
          ),
          pw.Text('Jl. Centralpark No. 10 Yogyakarta'),
          pw.SizedBox(height: 20),
          pw.Text('Laporan Penggunaan Bahan Baku', 
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              decoration: pw.TextDecoration.underline
            ) 
          ),
          pw.SizedBox(height: 5),
          pw.Text('Periode: $periode'),
          pw.SizedBox(height: 5),
          pw.Text('Tanggal Cetak: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}'),
          pw.SizedBox(height: 5),
          pw.Table.fromTextArray(
            headers: ['Nama Bahan', 'Satuan', 'Digunakan'],
            data: data.map((item) => [item.namaBahanBaku, item.satuan, item.digunakan.toString()]).toList(),
            border: pw.TableBorder.all(width: 1.0)
          )
        ];
      }
    )
  );

  Navigator.push(context, MaterialPageRoute(builder: (context) => Preview(pdf: pdf)));
}

class Preview extends StatelessWidget {
  final pw.Document pdf;

  Preview({required this.pdf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Laporan'),
      ),
      body: PdfPreview(
        build: (format) => pdf.save(),
      )
    );
  }
}