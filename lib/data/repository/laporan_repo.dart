import 'dart:convert';
import 'package:http/http.dart';
import 'package:frontend_mobile/data/model/bahan_baku.dart';

class LaporanRepository {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/';

  Future<List<BahanBaku>> fetchBahanBaku() async {
    try{
      var response = await get(Uri.http(url, "${endpoint}bahan_baku"));

      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      List data = json.decode(response.body)['data'];
      return data.map((e) => BahanBaku.fromJson(e)).toList();
    }catch(e){
      return Future.error(e.toString());
    }
  }
}