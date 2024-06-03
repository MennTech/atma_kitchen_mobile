import 'package:flutter/material.dart';
import 'package:frontend_mobile/data/model/bahan_baku.dart';
import 'package:frontend_mobile/data/repository/laporan_repo.dart';

class TabelBahanBaku extends StatefulWidget {
  const TabelBahanBaku({super.key});

  @override
  State<TabelBahanBaku> createState() => _TabelBahanBakuState();
}

class _TabelBahanBakuState extends State<TabelBahanBaku> {
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
    
    if(allBahanBaku == null ){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if(allBahanBaku!.isEmpty){
      return const Center(
        child: Text('Data Kosong'),
      );
    }

    return DataTable(
      border: TableBorder.all(width: 1.0, color: Colors.black),
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Nama Bahan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Satuan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Stok',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )
        ),
      ],
      rows: allBahanBaku!.map((e) => DataRow(
        cells: <DataCell>[
          DataCell(Text(e.namaBahanBaku)),
          DataCell(Text(e.satuan)),
          DataCell(Text(e.stok.toString())),
        ]
      )).toList(),
    );
  }
}