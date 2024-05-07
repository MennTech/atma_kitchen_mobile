import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: HexColor("#F9F9F1"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // make it at the middle
          Container(
            alignment: Alignment.center,
            width: size.width,
            height: size.height * (4 / 5),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Atma Kitchen',
                    style: TextStyle(
                      color: HexColor("#65390E"),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Surga Kelezatan, Harmoni Rasa yang Memanjakan Jiwa. Di sini, kami mengolah setiap produk dengan penuh cinta, menciptakan sajian yang memanjakan lidah sekaligus menghanyutkan perasaan Anda.',
                    style: TextStyle(
                      color: HexColor("#65390E"),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: size.width,
            // height: size.height * (1 / 5),
            decoration: BoxDecoration(
                color: HexColor("#FFFFFF"),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            // create two button for login customer and login karyawan
            child: Padding(
              padding: EdgeInsets.only(top: 24, bottom: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 // change to gesture
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Container(
                      width: size.width * (4 / 5),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      decoration: BoxDecoration(
                          color: HexColor("#65390E"),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: HexColor("#F9F9F1"),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
