import "package:frontend_mobile/data/model/saldo.dart";
import 'package:http/http.dart';
import 'dart:convert';

class SaldoRepository {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/';

  Future<List<Saldo>> fetchSaldo(String token) async {
    try {
      var response = await get(
          Uri.http(url, "${endpoint}customer/history-saldo"),
          headers: {"Authorization": 'Bearer ${token}'});

      if (response.statusCode != 200) {
        throw Exception('Failed to load saldo: ${response.reasonPhrase}');
      }

      List data = json.decode(response.body)['data'];
      return data.map((e) => Saldo.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching saldo: $e');
      return Future.error('Error fetching saldo: $e');
    }
  }

  Future<Response> tarikSaldo(
      String nomorRekening, double nominal, String token) async {
    try {
      var response = await post(
          Uri.http(url, "${endpoint}customer/penarikan-saldo"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer $token'
          },
          body: json
              .encode({"nominal": nominal, "nomor_rekening": nomorRekening}));

      if (response.statusCode != 200) {
        throw Exception('Failed to tarik saldo: ${response.reasonPhrase}');
      }

      return response;
    } catch (e) {
      print('Error tarik saldo: $e');
      return Future.error('Error tarik saldo: $e');
    }
  }
}
