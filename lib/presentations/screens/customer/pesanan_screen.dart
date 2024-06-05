import 'package:flutter/material.dart';
import 'package:frontend_mobile/data/model/pesanan.dart';
import 'package:frontend_mobile/data/repository/pesanan_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:frontend_mobile/constant.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {

  List<Pesanan> allPesanan = [];

  void refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    List<Pesanan> pesananData = await PesananRepository().fetchPesanan(token!);
    setState(() {
      allPesanan = pesananData;
      Future.delayed(const Duration(seconds: 5));
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if(allPesanan.isEmpty){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pesanan',
          style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
        ),
        body: const Center(
          child: Text('Tidak ada pesanan',
          style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold
          ),),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan',
        style: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),

        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: size.height,
          child: ListView.builder(
            itemCount: allPesanan?.length,
            itemBuilder: (context, index){
              return Card(
                key: ValueKey(allPesanan![index].id_pesanan),
                elevation: 3,
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    "Pesanan #${DateFormat('yy.MM').format(DateTime.parse(allPesanan![index].tanggal_pesan))}.${allPesanan![index].id_pesanan}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                  child: Text(
                                    'Status ${allPesanan![index].status}',
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
                            in allPesanan![index].detailPesanan)
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
                                  child: Image.network(
                                      item.produk != null ? 
                                      endpointImage+item.produk!.gambar_produk :
                                      endpointImage+item.hampers!.gambar_hampers,
                                      // 'assets/images/download.jpeg'
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10),
                          child: Text(
                            "Total: Rp ${allPesanan![index].total}",
                            style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            onPressed: () async {
                              await PesananRepository().updateStatusPesanan('Selesai', allPesanan![index].id_pesanan);
                              refresh();
                            },
                            child: const Text('Selesai'), 
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}