
import 'dart:convert';
import 'package:http/http.dart' as http;

class LaporanRepository {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/';

  Future<Map<String, dynamic>> getLaporanPemasukanPengeluaran(int bulan, int tahun) async {
    try {
      final response = await http.post(
        Uri.http(url, "${endpoint}laporan-transaksi"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "bulan": bulan,
          "tahun": tahun,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception('Failed to get laporan pemasukan pengeluaran: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error getting laporan pemasukan pengeluaran: $e');
      throw Exception('Error getting laporan pemasukan pengeluaran: $e');
    }
  }
}
