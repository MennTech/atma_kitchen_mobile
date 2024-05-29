import 'package:flutter/material.dart';
import 'package:frontend_mobile/data/model/produk.dart';
import 'package:frontend_mobile/presentations/screens/auth/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:frontend_mobile/data/repository/produk.dart';
import 'package:frontend_mobile/constant.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(top: 100, bottom: 100),
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover,
                  opacity: 0.6,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      "Atma Kitchen",
                      style: GoogleFonts.pacifico(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Rasakan Cinta di Setiap Lapisan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 20),
                      Material(
                        color: HexColor("#8F5C54"),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Our Products",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ProductSection(),  // Menggunakan ProductSection di sini
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "About Us",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AboutUsSection(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class ProductSection extends StatelessWidget {
  final ProdukRepository produkRepository = ProdukRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Produk>>(
      future: produkRepository.fetchProduct(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products available.'));
        } else {
          final products = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        endpointImage+product.gambar_produk,
                        width: 800,
                        height: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        product.nama_produk,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Harga: ${product.harga}',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

class AboutUsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to Atma Kitchen",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Atma Kitchen adalah toko kue yang didedikasikan untuk membawa kebahagiaan melalui setiap gigitan. Kami percaya bahwa setiap kue memiliki cerita, dan di Atma Kitchen, kami berusaha untuk membuat setiap cerita itu istimewa.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Our Story",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Bermula dari dapur kecil di rumah, Atma Kitchen lahir dari cinta kami terhadap seni pembuatan kue dan keinginan untuk berbagi kebahagiaan dengan orang lain. Nama 'Atma' diambil dari bahasa Sansekerta yang berarti 'jiwa', mencerminkan komitmen kami untuk menaruh hati dan jiwa kami dalam setiap kue yang kami buat.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(15), // Set the border radius here
            child: Image.asset("assets/images/preview.jpg"),  // Gambar pertama
          ),
          SizedBox(height: 20),
          Text(
            "Our Mission",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Misi kami adalah untuk menciptakan kue yang tidak hanya lezat tetapi juga indah dipandang. Kami menggunakan bahan-bahan berkualitas tinggi, resep tradisional yang diwariskan secara turun-temurun, dan sentuhan inovasi untuk menghasilkan kue yang menggugah selera dan menyentuh hati.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Visit Us",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Kami mengundang Anda untuk mengunjungi toko kami dan merasakan sendiri kelezatan dan keindahan kue kami. Atma Kitchen adalah tempat di mana cita rasa bertemu dengan keahlian, dan setiap kue adalah cerminan dari dedikasi kami untuk menyajikan yang terbaik.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Temukan keajaiban di setiap gigitan, hanya di Atma Kitchen.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
