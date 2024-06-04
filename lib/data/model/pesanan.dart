import 'dart:convert';
import 'package:frontend_mobile/data/model/detail_pesanan.dart';

class Pesanan {
  String id_pesanan;
  String id_customer;
  String tanggal_pesan;
  String tanggal_ambil;
  String tanggal_lunas;
  String alamat;
  String delivery;
  int total;
  int ongkos_kirim;
  int? tip;
  String status;
  int jumlah_pembayaran;
  int poin_dipakai;
  int poin_dapat;
  String bukti_pembayaran;
  List<DetailPesanan> detailPesanan;

  Pesanan({
    required this.id_pesanan,
    required this.id_customer,
    required this.tanggal_pesan,
    required this.tanggal_ambil,
    required this.tanggal_lunas,
    required this.alamat,
    required this.delivery,
    required this.total,
    required this.ongkos_kirim,
    this.tip,
    required this.status,
    required this.jumlah_pembayaran,
    required this.poin_dipakai,
    required this.poin_dapat,
    required this.bukti_pembayaran,
    required this.detailPesanan
  });

  factory Pesanan.fromRawJson(String str) => Pesanan.fromJson(json.decode(str));

  factory Pesanan.fromJson(Map<String, dynamic> data) {
    return Pesanan(
      id_pesanan: data['id_pesanan'].toString(),
      id_customer: data['id_customer'].toString(),
      tanggal_pesan: data['tanggal_pesan'],
      tanggal_ambil: data['tanggal_ambil'],
      tanggal_lunas: data['tanggal_lunas'],
      alamat: data['alamat'],
      delivery: data['delivery'],
      total: data['total'],
      ongkos_kirim: data['ongkos_kirim'],
      tip: data['tip'] ?? 0,
      status: data['status'],
      jumlah_pembayaran: data['jumlah_pembayaran'],
      poin_dipakai: data['poin_dipakai'],
      poin_dapat: data['poin_didapat'],
      bukti_pembayaran: data['bukti_pembayaran'],
      detailPesanan: data['detail_pesanan']
          .map<DetailPesanan>((e) => DetailPesanan.fromJson(e))
          .toList()
    );
  }

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id_pesanan': id_pesanan,
        'id_customer': id_customer,
        'tanggal_pesan': tanggal_pesan,
        'tanggal_ambil': tanggal_ambil,
        'tanggal_lunas': tanggal_lunas,
        'alamat': alamat,
        'delivery': delivery,
        'total': total,
        'ongkos_kirim': ongkos_kirim,
        'tip': tip,
        'status': status,
        'jumlah_pembayaran': jumlah_pembayaran,
        'poin_dipakai': poin_dipakai,
        'poin_dapat': poin_dapat,
        'bukti_pembayaran': bukti_pembayaran,
        'detail_pesanan': detailPesanan
      };
}
