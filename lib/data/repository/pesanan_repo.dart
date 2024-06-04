import "package:frontend_mobile/data/model/pesanan.dart";
import 'package:http/http.dart';
import 'dart:convert';

class PesananRepository {
  static const String url = '10.0.2.2:8000'; // using emulator
  static const String endpoint = '/api/';

  Future<List<Pesanan>> fetchHistory(String token) async {
    try {
      var response = await get(Uri.http(url, "${endpoint}customer/history"),
          headers: {"Authorization": 'Bearer ${token}'});

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      List data = json.decode(response.body)['data'];
      return data.map((e) => Pesanan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Pesanan>> fetchPesanan(String token) async {
    try {
      var response = await get(Uri.http(url, "${endpoint}customer/pesanan-dikirim-pickup"),
      headers: {"Authorization": 'Bearer ${token}'});

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      List data = json.decode(response.body)['data'];
      return data.map((e) => Pesanan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future updateStatusPesanan(String status, String idPesanan) async {
    try {
      await put(Uri.http(url, "${endpoint}update-status-pesanan/${idPesanan}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"status": status}));
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
