import 'dart:convert';

class BahanBaku {
  int idBahanBaku;
  String namaBahanBaku;
  int stok;
  String satuan;

  BahanBaku({
    required this.idBahanBaku,
    required this.namaBahanBaku,
    required this.stok,
    required this.satuan,
  });

  factory BahanBaku.fromRawJson(String str) =>
      BahanBaku.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BahanBaku.fromJson(Map<String, dynamic> json) =>
      BahanBaku(
        idBahanBaku: json["id_bahan_baku"],
        namaBahanBaku: json["nama_bahan_baku"],
        stok: json["stok"],
        satuan: json["satuan"],
      );

  Map<String, dynamic> toJson() => {
        "id_bahan_baku": idBahanBaku,
        "nama_bahan_baku": namaBahanBaku,
        "stok": stok,
        "satuan": satuan,
      };
}
