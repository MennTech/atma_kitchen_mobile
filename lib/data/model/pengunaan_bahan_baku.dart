import 'dart:convert';

class PenggunaanBahanBaku{
  String namaBahanBaku;
  String satuan;
  int digunakan;

  PenggunaanBahanBaku({
    required this.namaBahanBaku,
    required this.satuan,
    required this.digunakan,
  });

  factory PenggunaanBahanBaku.fromRawJson(String str) =>
      PenggunaanBahanBaku.fromJson(json.decode(str));
  
  String toRawJson() => json.encode(toJson());

  factory PenggunaanBahanBaku.fromJson(Map<String, dynamic> json) =>
      PenggunaanBahanBaku(
        namaBahanBaku: json["nama_bahan_baku"],
        satuan: json["satuan"],
        digunakan: json["digunakan"],
      );
  
  Map<String, dynamic> toJson() => {
    "nama_bahan_baku": namaBahanBaku,
    "satuan": satuan,
    "digunakan": digunakan,
  };
}