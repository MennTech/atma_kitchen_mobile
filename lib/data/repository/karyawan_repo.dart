import 'package:frontend_mobile/data/model/karyawan.dart';
import 'package:http/http.dart';
import 'dart:convert';

class KaryawanRepository {
  static const String url = '10.0.2.2:8000'; // using emulator
  static const String endpoint = '/api/';

  Future<List<Karyawan>> fetchKaryawan() async {
    try {
      var response = await get(Uri.http(url, "${endpoint}karyawan"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable data = json.decode(response.body)['data'];
      return data.map((e) => Karyawan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
