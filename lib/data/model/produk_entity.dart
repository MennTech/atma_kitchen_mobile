import "dart:convert";

class Produk {
  int idProduk;
  int? idPenitip;
  String gambarProduk;
  String namaProduk;
  String deskripsiProduk;
  int harga;
  String kategori;
  String status;
  int stokTersedia;
  int? idResep;

  Produk({
    required this.idProduk,
    this.idPenitip,
    required this.gambarProduk,
    required this.namaProduk,
    required this.deskripsiProduk,
    required this.harga,
    required this.kategori,
    required this.status,
    required this.stokTersedia,
    this.idResep,
  });

  factory Produk.fromRawJson(String str) => Produk.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        idProduk: json["id_produk"],
        idPenitip: json["id_penitip"],
        gambarProduk: json["gambar_produk"],
        namaProduk: json["nama_produk"],
        deskripsiProduk: json["deskripsi_produk"],
        harga: json["harga"],
        kategori: json["kategori"],
        status: json["status"],
        stokTersedia: json["stok_tersedia"],
        idResep: json["id_resep"],
      );

  Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "id_penitip": idPenitip,
        "gambar_produk": gambarProduk,
        "nama_produk": namaProduk,
        "deskripsi_produk": deskripsiProduk,
        "harga": harga,
        "kategori": kategori,
        "status": status,
        "stok_tersedia": stokTersedia,
        "id_resep": idResep,
      };
}
