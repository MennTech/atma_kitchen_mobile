import 'dart:convert';

class Hampers{
  String id_hampers;
  String nama_hampers;
  int harga;

  Hampers(
      {required this.id_hampers,
        required this.nama_hampers,
        required this.harga}
  );

  factory Hampers.fromRawJson(String str) =>
      Hampers.fromJson(json.decode(str));
  factory Hampers.fromJson(Map<String, dynamic> data) {
    return Hampers(
        id_hampers: data['id_hampers'].toString(),
        nama_hampers: data['nama_hampers'],
        harga: data['harga']
    );
  }

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    'id_hampers': id_hampers,
    'nama_hampers': nama_hampers,
    'harga': harga
  };
}