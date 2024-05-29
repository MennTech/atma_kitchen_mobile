import 'dart:convert';
import 'produk_entity.dart';

class Hampers {
  int idHampers;
  String gambarHampers;
  String deskripsiHampers;
  String namaHampers;
  int harga;
  List<Produk> produk;

  Hampers({
    required this.idHampers,
    required this.gambarHampers,
    required this.deskripsiHampers,
    required this.namaHampers,
    required this.harga,
    required this.produk,
  });

  factory Hampers.fromRawJson(String str) => Hampers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hampers.fromJson(Map<String, dynamic> json) => Hampers(
        idHampers: json["id_hampers"],
        gambarHampers: json["gambar_hampers"],
        deskripsiHampers: json["deskripsi_hampers"],
        namaHampers: json["nama_hampers"],
        harga: json["harga"],
        produk:
            List<Produk>.from(json["produk"].map((x) => Produk.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_hampers": idHampers,
        "gambar_hampers": gambarHampers,
        "deskripsi_hampers": deskripsiHampers,
        "nama_hampers": namaHampers,
        "harga": harga,
        "produk": List<dynamic>.from(produk.map((x) => x.toJson())),
      };
}
