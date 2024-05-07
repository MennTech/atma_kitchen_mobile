import 'package:flutter/material.dart';
import 'package:frontend_mobile/data/model/presensi.dart';
import 'package:frontend_mobile/data/repository/presensi_repo.dart';

class PresensiScreen extends StatefulWidget {
  const PresensiScreen({super.key});

  @override
  State<PresensiScreen> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Presensi Hari Ini'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: size.width,
            ),
            child: const DataTableExample(),
          ),
        ));
  }
}

class DataTableExample extends StatefulWidget {
  const DataTableExample({super.key});

  @override
  State<DataTableExample> createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  List<Presensi>? allPresensi;

  Future<void> getPresensi() async {
    PresensiRepository().fetchPresensi().then((value) {
      setState(() {
        allPresensi = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPresensi();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      showBottomBorder: true,
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'No',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Nama',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Status',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: allPresensi != null
          ? allPresensi!
              .asMap()
              .entries
              .map(
                (entry) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text((entry.key + 1).toString())),
                    DataCell(Expanded(
                        child: Text(entry.value.karyawan.nama_karyawan))),
                    DataCell(DropdownButton<String>(
                        style: TextStyle(
                          color: entry.value.status == 'Hadir'
                              ? Colors.green
                              : Colors.red,
                        ),
                        value: entry.value.status,
                        onChanged: (String? newValue) {
                          PresensiRepository().updatePresensi(
                              entry.value.id_presensi, newValue!);
                          setState(() {
                            entry.value.status = newValue;
                          });
                        },
                        items: <String>['Hadir', 'Absen']
                            .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(
                                            color: value == 'Hadir'
                                                ? Colors.green
                                                : Colors.red,
                                          )),
                                    ))
                            .toList())),
                  ],
                ),
              )
              .toList()
          : [],
    );
  }
}
