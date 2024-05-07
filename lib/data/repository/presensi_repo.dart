import "package:frontend_mobile/data/model/presensi.dart";
import 'package:http/http.dart';
import 'dart:convert';

class PresensiRepository {
  static const String url = '10.0.2.2:8000'; // using emulator
  static const String endpoint = '/api/';

  Future<void> generatePresensi() async {
    var response = await get(Uri.http(url, "${endpoint}presensi"));
    print(response.body);
  }

  Future<List<Presensi>> fetchPresensi() async {
    try {
      var response = await get(Uri.http(url, "${endpoint}presensi/data"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      List data = json.decode(response.body)['data'];
      return data.map((e) => Presensi.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Response> updatePresensi(String id_presensi, String status) async {
    try {
      var response = await put(
          Uri.http(url, "${endpoint}presensi/$id_presensi"),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"status": status}));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
