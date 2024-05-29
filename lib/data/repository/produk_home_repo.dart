import "package:frontend_mobile/data/model/produk_entity.dart";
import "package:frontend_mobile/data/model/hampers_entity.dart";
import "package:frontend_mobile/data/model/limit_produk_entity.dart";
import 'package:http/http.dart';
import 'dart:convert';

class ProdukHomeRepository {
  static const String url = '10.0.2.2:8000'; // using emulator
  static const String endpoint = '/api/';

  Future<List<Produk>> fetchProdukAtmaKitchen() async {
    try {
      var response = await get(Uri.http(url, "${endpoint}produk/atma_kitchen"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      List data = json.decode(response.body)['produks'];
      return data.map((e) => Produk.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Produk>> fetchProdukPenitip() async {
    try{
      var response = await get(Uri.http(url, "${endpoint}produk/penitip"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      List data = json.decode(response.body)['produks'];
      return data.map((e) => Produk.fromJson(e)).toList();
    }catch(e){
      return Future.error(e.toString());
    }
  }

  Future<List<Hampers>> fetchHampers() async {
    try {
      var response = await get(Uri.http(url, "${endpoint}hampers"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      List data = json.decode(response.body)['data'];
      return data.map((e) => Hampers.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<LimitProduk>> fetchLimitProduk(String tanggal) async {
    try {
      
      var response = await get(Uri.http(url, "${endpoint}limit-produk/cari/tanggal", {"tanggal": tanggal}));
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      List data = json.decode(response.body)['data'];
      return data.map((e) => LimitProduk.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  String getPhotoProduk(String gambar) {
    return "http://$url/storage/produk/$gambar";
  }

  String getPhotoHampers(String gambar) {
    return "http://$url/storage/hampers/$gambar";
  }
}