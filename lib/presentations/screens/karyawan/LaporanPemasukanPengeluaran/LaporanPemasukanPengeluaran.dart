// laporan_transaksi.dart

import 'package:flutter/material.dart';
import 'package:frontend_mobile/data/repository/laporanPemasukanPengeluaran.dart';
import 'package:frontend_mobile/presentations/screens/karyawan/LaporanPemasukanPengeluaran/print_Pdf.dart';
import 'package:hexcolor/hexcolor.dart';

class LaporanTransaksi extends StatefulWidget {
  @override
  _LaporanTransaksiState createState() => _LaporanTransaksiState();
}

class _LaporanTransaksiState extends State<LaporanTransaksi> {
  String bulan = "";
  String tahun = "";
  List<dynamic> pemasukan = [];
  List<dynamic> pengeluaran = [];
  int totalPemasukan = 0;
  int totalPengeluaran = 0;
  bool loading = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Pemasukan dan Pengeluaran'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Laporan Pemasukan dan Pengeluaran',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Form(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Bulan'),
                      onChanged: (value) {
                        setState(() {
                          bulan = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Tahun'),
                      onChanged: (value) {
                        setState(() {
                          tahun = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                        error = "";
                      });
                      try {
                        final response = await LaporanRepository()
                            .getLaporanPemasukanPengeluaran(
                                int.parse(bulan), int.parse(tahun));
                        setState(() {
                          pemasukan = response['data']['pemasukan'] ?? [];
                          pengeluaran = response['data']['pengeluaran'] ?? [];
                          totalPemasukan = pemasukan[pemasukan.length - 1]['jumlah'];
                          totalPengeluaran = pengeluaran[pengeluaran.length - 1]['jumlah'];
                          pemasukan.removeAt(pemasukan.length - 1);
                          pengeluaran.removeAt(pengeluaran.length - 1);
                        });
                      } catch (e) {
                        setState(() {
                          error = e.toString();
                        });
                      } finally {
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    child: Text('Lihat Laporan'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            if (loading)
              CircularProgressIndicator()
            else if (pemasukan.isNotEmpty || pengeluaran.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Nama')),
                          DataColumn(label: Text('Pemasukan')),
                          DataColumn(label: Text('Pengeluaran')),
                        ],
                        rows: [
                          ...pemasukan.map((item) => DataRow(
                                cells: [
                                  DataCell(Text(item['nama'])),
                                  DataCell(Text(item['jumlah'].toString())),
                                  DataCell(Text('-')),
                                ],
                              )),
                          ...pengeluaran.map((item) => DataRow(
                                cells: [
                                  DataCell(Text(item['nama'])),
                                   DataCell(Text('-')),
                                  DataCell(Text(item['jumlah'].toString())),
                                ],
                              )),
                              DataRow(
                                cells: [
                                  DataCell(
                                    Text('Total')
                                  ),
                                  DataCell(
                                    Text(
                                      totalPemasukan.toString()
                                    )
                                  ),
                                  DataCell(
                                    Text(
                                      totalPengeluaran.toString()
                                    )
                                  )
                                ]
                              )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => generatePdf(pemasukan,pengeluaran,totalPemasukan,totalPengeluaran,bulan,tahun, context),
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
                  
                ),
              )
            else
              Text('Tidak ada data yang ditemukan.'),
            if (error.isNotEmpty)
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
