import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_mobile/data/model/hampers_entity.dart';
import 'package:frontend_mobile/data/model/limit_produk_entity.dart';
import 'package:frontend_mobile/data/model/produk_entity.dart';
import 'package:frontend_mobile/data/repository/produk_home_repo.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class HomeScreenCustomer extends StatefulWidget {
  const HomeScreenCustomer({super.key});

  @override
  State<HomeScreenCustomer> createState() => _HomeScreenCustomerState();
}

class _HomeScreenCustomerState extends State<HomeScreenCustomer> {
  List<Produk>? allProdukAtmaKitchen;
  List<Produk>? allProdukPenitip;
  List<LimitProduk>? allLimitProduk;
  List<Hampers>? allHampers;
  // get next two days
  final DateTime nextTwoDays = DateTime.now().add(const Duration(days: 2));

  Future<void> initProduk() async {
    ProdukHomeRepository().fetchProdukAtmaKitchen().then((value) {
      setState(() {
        allProdukAtmaKitchen = value;
      });
    });

    ProdukHomeRepository().fetchProdukPenitip().then((value) {
      setState(() {
        allProdukPenitip = value;
      });
    });

    ProdukHomeRepository().fetchHampers().then((value) {
      setState(() {
        allHampers = value;
      });
    });

    ProdukHomeRepository().fetchLimitProduk(DateFormat('yyyy-MM-dd').format(nextTwoDays)).then((value) {
      setState(() {
        allLimitProduk = value;
      });
    });
  }

  @override
  void initState() {
    initProduk();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final formattedDate = DateFormat('dd-MM-yyyy').format(nextTwoDays);

    int findLimitByProduk(int idProduk) {
      final limitProduk = allLimitProduk!.firstWhere((element) => element.idProduk == idProduk, orElse: () => LimitProduk(idLimitProduk: 0, idProduk: 0, tanggal: DateTime.now(), stok: 0));
      return limitProduk.stok;
    }

    String produkHampersToString(int idHampers){
      final hampers = allHampers!.firstWhere((element) => element.idHampers == idHampers, orElse: () => Hampers(idHampers: 0, namaHampers: '', gambarHampers: '', deskripsiHampers: "", harga: 0, produk: []));
      List<String> produk = hampers.produk.map((e) => e.namaProduk).toList();
      return produk.join(', ');
    }

    if (allProdukAtmaKitchen == null || allProdukPenitip == null || allHampers == null || allLimitProduk == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#F9F9F1"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tanggal Stok PO : $formattedDate'),
                const Text('Produk Atma Kitchen',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                allProdukAtmaKitchen!.isEmpty ? 
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Tidak ada produk'),
                ) : 
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.7,
                  shrinkWrap: true,
                  primary: true,
                  crossAxisCount: 2,
                  children: allProdukAtmaKitchen!.map((e) => 
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16/9,
                          child: 
                            ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                              child: 
                                Image.network(ProdukHomeRepository().getPhotoProduk(e.gambarProduk),
                                  fit: BoxFit.fitWidth
                                )
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.namaProduk, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text('Jenis Produk : ${e.kategori}'),
                              e.stokTersedia == 0 ? const SizedBox.shrink() : Text('Stok tersedia : ${e.stokTersedia}'),
                              Text('Stok PO : ${findLimitByProduk(e.idProduk)}'),
                              Text('Harga : ${NumberFormat.currency(locale: 'id', symbol: "Rp").format(e.harga)}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text('Hampers',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                allHampers!.isEmpty ?
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Tidak ada hampers'),
                ) :
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.7,
                  shrinkWrap: true,
                  primary: true,
                  crossAxisCount: 2,
                  children: allHampers!.map((e) => Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16/9,
                          child: 
                            ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                              child: 
                                Image.network(ProdukHomeRepository().getPhotoHampers(e.gambarHampers),
                                  fit: BoxFit.fitWidth
                                )
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.namaHampers, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text('Isi Hampers : ${produkHampersToString(e.idHampers)}'),
                              Text('Harga : ${NumberFormat.currency(locale: 'id', symbol: "Rp").format(e.harga)}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text('Produk Lainnya',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                allProdukPenitip!.isEmpty ?
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Tidak ada produk lainnya'),
                ) :
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.7,
                  shrinkWrap: true,
                  primary: true,
                  crossAxisCount: 2,
                  children: allProdukPenitip!.map((e) => Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16/9,
                          child: 
                            ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                              child: 
                                Image.network(ProdukHomeRepository().getPhotoProduk(e.gambarProduk),
                                  fit: BoxFit.fitWidth
                                )
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.namaProduk, style: const TextStyle(fontWeight: FontWeight.bold)),
                              e.stokTersedia == 0 ? const SizedBox.shrink() : Text('Stok tersedia : ${e.stokTersedia}'),
                              Text('Harga : ${NumberFormat.currency(locale: 'id', symbol: "Rp").format(e.harga)}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}