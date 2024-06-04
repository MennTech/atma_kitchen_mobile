import "package:flutter/material.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import "package:printing/printing.dart";
import 'package:frontend_mobile/data/model/bahan_baku.dart';

class GenerateLaporanBahanPdf {
  static Future<void> generateLaporanBahanPdf(List<BahanBaku> allBahanBaku, BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(
          pageFormat: PdfPageFormat.a4
        ),
        build: (pw.Context context) {
          return [
            pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text(
                "Atma Kitchen",
                style: pw.TextStyle(
                  color: PdfColors.black,
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold
                ),
              )
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              "Laporan Bahan Baku",
              style: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 14,
                fontWeight: pw.FontWeight.bold
              )
            ),
            pw.Text(
              "Tanggal Cetak : ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
              style: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 14,
                fontWeight: pw.FontWeight.bold
              )
            ),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: <String>['Nama Bahan', 'Satuan', 'Stok'],
              data: allBahanBaku.map((e) => [e.namaBahanBaku, e.satuan, e.stok.toString()]).toList(),
              border: pw.TableBorder.all(width: 1.0)
            )
          ];
        }
      )
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewLaporanBahanPdf(pdf: pdf)));
  }
}

class PreviewLaporanBahanPdf extends StatelessWidget {
  final pw.Document pdf;

  const PreviewLaporanBahanPdf({required this.pdf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview Laporan Bahan Baku hari ini"),
      ),
      body: PdfPreview(
        build: (format) => pdf.save(),
      ),
    );
  }
}