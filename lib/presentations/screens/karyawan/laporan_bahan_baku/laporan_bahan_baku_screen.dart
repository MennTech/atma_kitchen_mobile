import 'package:flutter/material.dart';
import 'package:frontend_mobile/presentations/screens/karyawan/laporan_bahan_baku/tabel_bahan_baku.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:frontend_mobile/data/model/bahan_baku.dart';
import 'package:frontend_mobile/data/repository/laporan_repo.dart';
import 'package:frontend_mobile/presentations/screens/karyawan/laporan_bahan_baku/generate_laporan_bahan_pdf.dart';

class LaporanBahanBakuScreen extends StatefulWidget {
  const LaporanBahanBakuScreen({super.key});

  @override
  State<LaporanBahanBakuScreen> createState() => _LaporanBahanBakuScreenState();
}

class _LaporanBahanBakuScreenState extends State<LaporanBahanBakuScreen> {
  List<BahanBaku>? allBahanBaku;

  Future<void> getAllBahanBakuNow() async {
    LaporanRepository().fetchBahanBaku().then((value) {
      setState(() {
        allBahanBaku = value;
      });
    });
  }

  @override
  void initState() {
    getAllBahanBakuNow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    if (allBahanBaku == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tanggal : $formattedDate",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // button
                    ElevatedButton(
                      onPressed: () => GenerateLaporanBahanPdf.generateLaporanBahanPdf(allBahanBaku!, context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#65390E"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: 
                      const Text(
                        "Cetak Laporan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TabelBahanBaku( allBahanBaku: allBahanBaku )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}