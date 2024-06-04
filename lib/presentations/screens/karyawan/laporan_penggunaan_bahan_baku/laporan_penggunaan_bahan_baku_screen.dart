import 'package:flutter/material.dart';
import 'package:frontend_mobile/presentations/screens/karyawan/laporan_penggunaan_bahan_baku/tabel_penggunaan_bahan_baku.dart';

class LaporanPenggunaanBahanBakuScreen extends StatefulWidget {
  const LaporanPenggunaanBahanBakuScreen({super.key});

  @override
  State<LaporanPenggunaanBahanBakuScreen> createState() => _LaporanPenggunaanBahanBakuScreenState();
}

class _LaporanPenggunaanBahanBakuScreenState extends State<LaporanPenggunaanBahanBakuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Penggunaan Bahan Baku', 
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: TabelPenggunaanBahanBaku(),
        ),
      ),
    );
  }
}