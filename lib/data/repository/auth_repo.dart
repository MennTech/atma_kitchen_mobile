import 'dart:convert';
import 'package:frontend_mobile/data/model/customer.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const String url = '10.0.2.2:8000'; // using emulator
  static const String endpoint = '/api/';
  // static const String url = '192.168.1.9:8000'; // using real device. Tergantung ipv4 kalian
  // static const String endpoint = '/api/';

  String? tokenBearer;
  /* 
  Mon Ntar kau bikin login jangan lupa set kan nilai tokenBearer = token yang hasil respone, untuk aku nampilin profile 
  */

  Future<Map<String, dynamic>> loginCustomer(String email_customer, String password) async {
    var response = await post(Uri.http(url, "${endpoint}customer/login"),
        headers: {
          "Content-Type": "application/json",

        }, 
        body: json.encode({
          "email": email_customer,
          "password": password
        }));

    if(response.statusCode != 200) throw Exception(response.reasonPhrase);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> loginKaryawan(String emailKaryawan, String password) async {
    var response = await post(Uri.http(url, "${endpoint}karyawan/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "email_karyawan": emailKaryawan,
          "password": password
        }));

    if(response.statusCode != 200) throw Exception(response.reasonPhrase);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<void> logoutCustomer (String token) async {
    var response = await post(Uri.http(url, "${endpoint}customer/logout"),
      headers: {
        "Authorization": 'Bearer ${token}'
      });

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
    }
  }

  Future<void> logoutKaryawan (String token) async {
    var response = await post(Uri.http(url, "${endpoint}karyawan/logout"),
      headers: {
        "Authorization": 'Bearer ${token}'
      });

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
    }
  }
  Future<Customer> showProfile(String token) async {
    var respone =
        await get(Uri.http(url, "${endpoint}customer/profile"), headers: {
      "Authorization": 'Bearer ${token}'
    });

    if (respone.statusCode != 200) throw Exception(respone.reasonPhrase);

    Map<String, dynamic> dataCustomer = json.decode(respone.body);
    return Customer(
        nama: dataCustomer['nama_customer'].toString(),
        email: dataCustomer['email'],
        noTelp: dataCustomer['no_telp'],
        tglLahir: dataCustomer['tanggal_lahir'],
        poin: dataCustomer['poin'].toString(),
        saldo: dataCustomer['saldo'].toString());
  }
}
