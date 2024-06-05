import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_mobile/data/repository/auth_repo.dart';
import 'package:frontend_mobile/data/repository/saldo_repository.dart';
import 'package:frontend_mobile/data/model/customer.dart';
import 'package:frontend_mobile/data/model/saldo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_mobile/presentations/screens/customer/Tarik.dart';

class SaldoScreen extends StatelessWidget {
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              FutureBuilder<String>(
                future: getToken(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    String token = snapshot.data!;
                    return Column(
                      children: [
                        _buildProfileSection(token),
                        _buildHistorySection(token),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(width: 130.0),
        Text(
          "Saldo",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(String token) {
    return FutureBuilder<Customer>(
      future: AuthRepository().showProfile(token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          Customer customer = snapshot.data!;
          return _buildContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProfileColumn(customer.saldo),
                _buildTarikSaldoButton(context),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildProfileColumn(String saldo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        labelProfile("Saldo"),
        SizedBox(height: 10.0),
        valueProfile("Rp.$saldo"),
      ],
    );
  }

  Widget _buildTarikSaldoButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TarikSaldoScreen()),
        );
      },
      child: labelProfile("Tarik Saldo"),
    );
  }

  Widget _buildHistorySection(String token) {
    return FutureBuilder<List<Saldo>>(
      future: SaldoRepository().fetchSaldo(token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Saldo> saldoList = snapshot.data!;
          return _buildContainer(
            child: Column(
              children: [
                Text(
                  "Riwayat Saldo",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: saldoList.length,
                  itemBuilder: (context, index) {
                    Saldo saldo = saldoList[index];
                    return Card(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rp.${saldo.nominal}",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  saldo.tanggal,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            Text(
                              saldo.status,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
      child: child,
    );
  }
}

Text labelProfile(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
  );
}

Text valueProfile(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  );
}
