import 'package:flutter/material.dart';
import 'package:frontend_mobile/data/model/pesanan.dart';
import 'package:frontend_mobile/data/repository/pesanan_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Pesanan>? allPesanan;
  List<Pesanan>? filteredPesanan;

  void refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    List<Pesanan> pesananData = await PesananRepository().fetchPesanan(token!);
    setState(() {
      allPesanan = pesananData;
      filteredPesanan = pesananData;
      Future.delayed(const Duration(seconds: 5));
    });
  }

  @override
  void initState() {
    refresh();
    // filteredPesanan = allPesanan;
    super.initState();
  }

  void filter(String query) {
    List<Pesanan> filteredList = [];
    for (Pesanan pesanan in allPesanan!) {
      bool matchFound = false;
      for (var item in pesanan.detailPesanan) {
        if (item.produk != null &&
            item.produk!.nama_produk.toLowerCase().contains(query.toLowerCase())) {
          matchFound = true;
          break;
        } else if (item.hampers != null &&
            item.hampers!.nama_hampers.toLowerCase().contains(query.toLowerCase())) {
          matchFound = true;
          break;
        }
      }
      if (matchFound) {
        filteredList.add(pesanan);
      }
    }
    setState(() {
      filteredPesanan = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    if (allPesanan == null) {
      filteredPesanan = [];
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Pesanan',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                onChanged: (value) => filter(value),
                decoration: InputDecoration(
                    hintText: 'Cari Riwayat Pesanan',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: size.height * (1 / 1.5),
                child: ListView.builder(
                    itemCount: filteredPesanan!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        key: ValueKey(filteredPesanan![index].id_pesanan),
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          child: Text(
                                            "Pesanan #${DateFormat('yy.MM').format(DateTime.parse(filteredPesanan![index].tanggal_pesan))}.${allPesanan![index].id_pesanan}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                          child: Text(
                                            'Status ${filteredPesanan![index].status}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      height: 10,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                  ],
                                ),
                                for (var item
                                    in filteredPesanan![index].detailPesanan)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: SizedBox(
                                          width: size.width * (1 / 4),
                                          height: size.height * (1 / 10),
                                          child: const Image(
                                            image: AssetImage(
                                              // item.produk != null ? 
                                              // item.produk!.gambar_produk :
                                              // item.hampers!.gambar_hampers
                                              'assets/images/download.jpeg'
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                width: size.width * (1 / 2.5),
                                                height: size.height * (1 / 18),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(5, 10, 0, 0),
                                                    child: Text(
                                                      item.produk != null
                                                          ? item.produk!.nama_produk
                                                          : item.hampers!.nama_hampers,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    ),
                                              ),
                                              SizedBox(
                                                width: size.width * (1 / 2.5),
                                                // height: size.height * (1/10),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(left: 5),
                                                  child: Text(
                                                    'Jumlah: x${item.jumlah}',
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: size.width * (1 / 4),
                                            height: size.height * (1 / 13),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                                              child: Text(
                                                  'Rp ${item.produk != null
                                                  ? item.produk!.harga 
                                                  : item.hampers!.harga}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                const Divider(
                                  color: Colors.grey,
                                  height: 10,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                              ],
                            ),
                            Text(
                              "Total: Rp ${filteredPesanan![index].total}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
