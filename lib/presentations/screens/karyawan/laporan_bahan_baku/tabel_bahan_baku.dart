import 'package:flutter/material.dart';
import 'package:frontend_mobile/data/model/bahan_baku.dart';

class TabelBahanBaku extends StatefulWidget {
  final List<BahanBaku>? allBahanBaku;

  const TabelBahanBaku({super.key, this.allBahanBaku});

  @override
  State<TabelBahanBaku> createState() => _TabelBahanBakuState();
}

class _TabelBahanBakuState extends State<TabelBahanBaku> {
  // List<BahanBaku>? allBahanBaku;

  @override
  Widget build(BuildContext context) {
    List<BahanBaku>? allBahanBaku = widget.allBahanBaku;
    
    if(allBahanBaku == null ){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if(allBahanBaku.isEmpty){
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
            ),
          )
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Satuan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
            ),
          )
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Stok',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
            ),
          )
        ),
      ],
      rows: allBahanBaku.map((e) => DataRow(
        cells: <DataCell>[
          DataCell(Text(e.namaBahanBaku)),
          DataCell(Text(e.satuan)),
          DataCell(Text(e.stok.toString())),
        ]
      )).toList(),
    );
  }
}