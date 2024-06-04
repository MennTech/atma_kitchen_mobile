import 'package:flutter/material.dart';
import 'package:frontend_mobile/data/model/pengunaan_bahan_baku.dart';
import 'package:frontend_mobile/data/repository/laporan_repo.dart';
import 'package:intl/intl.dart';
import 'package:frontend_mobile/presentations/screens/karyawan/laporan_penggunaan_bahan_baku/laporan_pdf.dart';

class TabelPenggunaanBahanBaku extends StatefulWidget {
  const TabelPenggunaanBahanBaku({super.key});

  @override
  State<TabelPenggunaanBahanBaku> createState() => _TabelPenggunaanBahanBakuState();
}

class _TabelPenggunaanBahanBakuState extends State<TabelPenggunaanBahanBaku> {
  List<PenggunaanBahanBaku>? allPenggunaanBahanBaku;
  DateTime? startDate;
  DateTime? endDate;

  Future<void> getAllPenggunaanBahanBakuNow() async {
    LaporanRepository().fetchPenggunaanBahanBaku(startDate, endDate).then((value) {
      setState(() {
        allPenggunaanBahanBaku = value;
      });
    });
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
      getAllPenggunaanBahanBakuNow();
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
      getAllPenggunaanBahanBakuNow();
    }
  }

  

  @override
  void initState() {
    endDate = DateTime.now();
    startDate = DateTime.now().subtract(const Duration(days: 7));
    getAllPenggunaanBahanBakuNow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (allPenggunaanBahanBaku == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (allPenggunaanBahanBaku!.isEmpty) {
      return const Center(
        child: Text('Data Kosong'),
      );
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectStartDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                      text: startDate != null ? DateFormat('yyyy-MM-dd').format(startDate!) : '',
                    ),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      labelText: 'Start Date',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      )
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectEndDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                      text: endDate != null ? DateFormat('yyyy-MM-dd').format(endDate!) : '',
                    ),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      labelText: 'End Date',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            DataTable(
              border: TableBorder.all(width: 1.0, color: Colors.black),
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Nama Bahan',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Satuan',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Digunakan',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
              rows: allPenggunaanBahanBaku!.map((e) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(e.namaBahanBaku)),
                  DataCell(Text(e.satuan)),
                  DataCell(Text(e.digunakan.toString())),
                ],
              )).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => generatePdf(allPenggunaanBahanBaku!, '${DateFormat('yyyy-MM-dd').format(startDate!)} - ${DateFormat('yyyy-MM-dd').format(endDate!)}', context),
              child: const Text('Generate PDF'),
            ),
          ],
        ),
      ],
    );
  }
}