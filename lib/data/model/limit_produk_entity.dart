import 'dart:convert';
class LimitProduk {
  int idLimitProduk;
  int idProduk;
  DateTime tanggal;
  int stok;

  LimitProduk({
    required this.idLimitProduk,
    required this.idProduk,
    required this.tanggal,
    required this.stok,
  });

  factory LimitProduk.fromRawJson(String str) =>
      LimitProduk.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LimitProduk.fromJson(Map<String, dynamic> json) =>
      LimitProduk(
        idLimitProduk: json["id_limit_produk"],
        idProduk: json["id_produk"],
        tanggal: DateTime.parse(json["tanggal"]),
        stok: json["stok"],
      );

  Map<String, dynamic> toJson() => {
        "id_limit_produk": idLimitProduk,
        "id_produk": idProduk,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "stok": stok,
      };
}
