import 'dart:convert';
import 'package:frontend_mobile/data/model/customer.dart';
import 'package:http/http.dart';

class AuthRepository {
  static const String url = '10.0.2.2:8000';
  static const String endpoint = '/api/';

  String? tokenBearer;
  /* 
  Mon Ntar kau bikin login jangan lupa set kan nilai tokenBearer = token yang hasil respone, untuk aku nampilin profile 
  */

  Future<Customer> showProfile() async {
    var respone =
        await get(Uri.http(url, "${endpoint}customer/profile"), headers: {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000",
      "Authorization": 'Bearer $tokenBearer'
    });

    if (respone.statusCode != 200) throw Exception(respone.reasonPhrase);

    Map<String, dynamic> dataCustomer = json.decode(respone.body)['data'];
    return Customer(
        nama: dataCustomer['nama_customer'],
        email: dataCustomer['email_customer'],
        noTelp: dataCustomer['no_telp'],
        tglLahir: dataCustomer['tanggal_lahir'],
        poin: dataCustomer['poin'],
        saldo: dataCustomer['saldo']);
  }
}
