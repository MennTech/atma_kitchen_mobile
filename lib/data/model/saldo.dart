import 'dart:convert';

class Saldo {
  String id_history_saldo;
  int id_customer;
  String tanggal;
  String status;
  double nominal;
  String nomor_rekening;

  Saldo({
    required this.id_history_saldo,
    required this.id_customer,
    required this.tanggal,
    required this.status,
    required this.nominal,
    required this.nomor_rekening,
  });

  factory Saldo.fromRawJson(String str) => Saldo.fromJson(json.decode(str));

  factory Saldo.fromJson(Map<String, dynamic> data) {
    return Saldo(
      id_history_saldo: data['id_history_saldo'].toString(),
      id_customer: data['id_customer'],
      tanggal: data['tanggal'],
      status: data['status'],
      nominal: data['nominal'].toDouble(),
      nomor_rekening: data['nomor_rekening'],
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id_history_saldo': id_history_saldo,
        'id_customer': id_customer,
        'tanggal': tanggal,
        'status': status,
        'nominal': nominal,
        'nomor_rekening': nomor_rekening,
      };
}
