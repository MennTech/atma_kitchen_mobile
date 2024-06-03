import 'package:flutter/material.dart';
import 'package:frontend_mobile/presentations/screens/karyawan/laporan_bahan_baku/tabel_bahan_baku.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class LaporanBahanBakuScreen extends StatefulWidget {
  const LaporanBahanBakuScreen({super.key});

  @override
  State<LaporanBahanBakuScreen> createState() => _LaporanBahanBakuScreenState();
}

class _LaporanBahanBakuScreenState extends State<LaporanBahanBakuScreen> {
  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#F9F9F1"),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Laporan Bahan Baku",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tanggal Cetak: $formattedDate",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const TabelBahanBaku(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}