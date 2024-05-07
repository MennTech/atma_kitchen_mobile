import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_mobile/data/repository/auth_repo.dart';

class ProfileKaryawan extends StatefulWidget {
  const ProfileKaryawan({super.key});

  @override
  State<ProfileKaryawan> createState() => _ProfileKaryawanState();
}

class _ProfileKaryawanState extends State<ProfileKaryawan> {
  String? namaKaryawan;
  String? token;
  String? role;
  
  void getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      namaKaryawan = prefs.getString('namaKaryawan');
      role = prefs.getString('role');
    });
  }

  void logoutKaryawan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      String token = prefs.getString('token')!;
      await AuthRepository().logoutKaryawan(token);
      prefs.remove('token');
      prefs.remove('namaKaryawan');
      prefs.remove('role');
    }catch(error){
      log(error.toString());
    }
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (namaKaryawan == null || role == null || token == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Anda'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Text("Anda login sebagai : ", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(Icons.account_circle, size: 120, color: Colors.black),
                    Text(namaKaryawan!,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(role!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                minimumSize: MaterialStateProperty.all(Size(double.infinity, 48)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
              ),
              onPressed: () {
                logoutKaryawan();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              },
              child: Text('Logout', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          )
        ],
      ),
    );
  }
}