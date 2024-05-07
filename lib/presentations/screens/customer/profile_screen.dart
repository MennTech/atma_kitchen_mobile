import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend_mobile/data/repository/auth_repo.dart';
import 'package:frontend_mobile/presentations/screens/home_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:frontend_mobile/data/model/customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Customer? data;

  void refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Customer? customerData = await AuthRepository().showProfile(token!);
    setState(() {
      data = customerData;
      Future.delayed(const Duration(seconds: 5));
    });
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      String token = prefs.getString('token')!;
      await AuthRepository().logoutCustomer(token);
      prefs.remove('token');
    }catch(error){
      log(error.toString());
    }
      
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    if (data == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      backgroundColor: HexColor("#F9F9F1"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: size.width,
              height: size.height * (1 / 7),
              decoration: BoxDecoration(
                  color: HexColor("#65390E"),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 55, 24, 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style:
                          TextStyle(fontSize: 24, color: HexColor("#F9F9F1")),
                    ),
                  ],
                ),
              )),
          Container(
            margin: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            width: size.width,
            height: size.height * (1 / 2),
            decoration: BoxDecoration(
                color: HexColor("#65390E"),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Diri',
                    style: TextStyle(color: HexColor("#F9F9F1"), fontSize: 22),
                  ),
                  Divider(
                    color: HexColor("#F9F9F1"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelProfile("Nama Customer"),
                        // ignore: unnecessary_string_interpolations
                        valueProfile(data!.nama)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelProfile("Email"),
                        valueProfile(data!.email)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelProfile("No Telepon"),
                        valueProfile(data!.noTelp)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelProfile("Tanggal Lahir"),
                        valueProfile(data!.tglLahir)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelProfile("Poin"),
                        valueProfile(data!.poin)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelProfile("Saldo"),
                        valueProfile(data!.saldo)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * (1 / 8),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 40.0),
                  child: ElevatedButton(
                    onPressed: null, // Isi dengan route ubah password
                    child: Text('Ubah Password'),
                    style: ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size(150, 50))),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    logout();
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  }, 
                  child: Text('Logout'),
                  style: ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size(150, 50))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Text labelProfile(String text) {
  return Text(
    text,
    style: TextStyle(
      color: HexColor("#F9F9F1").withOpacity(0.8),
      fontSize: 12,
    ),
  );
}

Text valueProfile(String text) {
  return Text(
    text,
    style: TextStyle(
      color: HexColor("#F9F9F1"),
      fontSize: 16,
    ),
  );
}
