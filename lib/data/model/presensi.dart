import 'dart:convert';

import 'package:frontend_mobile/data/model/karyawan.dart';

class Presensi {
  String id_presensi;
  String id_karyawan;
  String tanggal;
  String status;
  Karyawan karyawan;

  Presensi(
      {required this.id_presensi,
      required this.id_karyawan,
      required this.tanggal,
      required this.status,
      required this.karyawan});

  factory Presensi.fromRawJson(String str) =>
      Presensi.fromJson(json.decode(str));
  factory Presensi.fromJson(Map<String, dynamic> data) {
    return Presensi(
        id_presensi: data['id_presensi'].toString(),
        id_karyawan: data['id_karyawan'].toString(),
        tanggal: data['tanggal'],
        status: data['status'],
        karyawan: Karyawan.fromJson(data['karyawan']));
  }

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id_presensi': id_presensi,
        'id_karyawan': id_karyawan,
        'tanggal': tanggal,
        'status': status,
        'karyawan': karyawan
      };
}
