import "package:frontend_mobile/data/model/produk.dart";
import 'package:http/http.dart';
import 'dart:convert';

class ProdukRepository {
  static const String url = '10.0.2.2:8000'; 
  static const String endpoint = '/api/';

  Future<List<Produk>> fetchProduct() async {
    try {
      var response = await get(Uri.http(url, "${endpoint}produk/produk"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      List data = json.decode(response.body)['data'];
      return data.map((e) => Produk.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
