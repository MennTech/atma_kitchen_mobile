import 'dart:convert';
import 'package:frontend_mobile/data/model/hampers.dart';
import 'package:frontend_mobile/data/model/produk.dart';

class DetailPesanan {
  String id_pesanan;
  int? id_produk;
  int? id_hampers;
  int jumlah;
  int subtotal;
  Produk? produk;
  Hampers? hampers;

  DetailPesanan(
      {required this.id_pesanan,
      this.id_produk,
      this.id_hampers,
      required this.jumlah,
      required this.subtotal,
      this.produk,
      this.hampers});

  factory DetailPesanan.fromRawJson(String str) =>
      DetailPesanan.fromJson(json.decode(str));
  factory DetailPesanan.fromJson(Map<String, dynamic> data) {
    return DetailPesanan(
        id_pesanan: data['id_pesanan'].toString(),
        id_produk: data['id_produk'] ?? 0,
        id_hampers: data['id_hampers'] ?? 0,
        jumlah: data['jumlah'],
        subtotal: data['subtotal'],
        produk: data['produk'] != null ? Produk.fromJson(data['produk']) : null,
        hampers:
            data['hampers'] != null ? Hampers.fromJson(data['hampers']) : null);
  }
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id_pesanan': id_pesanan,
        'id_produk': id_produk,
        'id_hampers': id_hampers,
        'jumlah': jumlah,
        'subtotal': subtotal,
        'produk': produk,
        'hampers': hampers
      };
}
