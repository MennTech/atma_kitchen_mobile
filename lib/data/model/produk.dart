import 'dart:convert';

class Produk{
  String id_produk;
  int? id_penitip;
  String gambar_produk;
  String nama_produk;
  String deskripsi_produk;
  int harga;
  String kategori;
  String status;
  int stok_tersedia;
  String id_resep;

  Produk(
      {required this.id_produk,
      this.id_penitip,
      required this.gambar_produk,
      required this.nama_produk,
      required this.deskripsi_produk,
      required this.harga,
      required this.kategori,
      required this.status,
      required this.stok_tersedia,
      required this.id_resep}
  );

  factory Produk.fromRawJson(String str) =>
      Produk.fromJson(json.decode(str));
  factory Produk.fromJson(Map<String, dynamic> data) {
    return Produk(
        id_produk: data['id_produk'].toString(),
        id_penitip: data['id_penitip'] ?? 0,
        gambar_produk: data['gambar_produk'],
        nama_produk: data['nama_produk'],
        deskripsi_produk: data['deskripsi_produk'],
        harga: data['harga'],
        kategori: data['kategori'],
        status: data['status'],
        stok_tersedia: data['stok_tersedia'],
        id_resep: data['id_resep'].toString()
    );
  }

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    'id_produk': id_produk,
    'id_penitip': id_penitip,
    'gambar_produk': gambar_produk,
    'nama_produk': nama_produk,
    'deskripsi_produk': deskripsi_produk,
    'harga': harga,
    'kategori': kategori,
    'status': status,
    'stok_tersedia': stok_tersedia,
    'id_resep': id_resep
  };
}