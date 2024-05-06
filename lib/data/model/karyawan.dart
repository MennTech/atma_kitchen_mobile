import 'dart:convert';

class Karyawan {
  String id_karyawan;
  int id_role;
  String nama_karyawan;
  String? email_karyawan;
  String no_telp;
  String? password;
  String? bonus;

  Karyawan(
      {required this.id_karyawan,
      required this.id_role,
      required this.nama_karyawan,
      this.email_karyawan,
      required this.no_telp,
      this.password,
      this.bonus});

    factory Karyawan.fromRawJson(String str) => Karyawan.fromJson(json.decode(str));
    factory Karyawan.fromJson(Map<String, dynamic> json) => Karyawan(
      id_karyawan: json['id_karyawan'],
      id_role: json['id_role'],
      nama_karyawan: json['nama_karyawan'],
      email_karyawan: json['email_karyawan'],
      no_telp: json['no_telp'],
      password: json['password'],
      bonus: json['bonus'],
    );

    String toRawJson() => json.encode(toJson());
    Map<String, dynamic> toJson() => {
      'id_karyawan': id_karyawan,
      'id_role': id_role,
      'nama_karyawan': nama_karyawan,
      'email_karyawan': email_karyawan,
      'no_telp': no_telp,
      'password': password,
      'bonus': bonus,
    };
}
