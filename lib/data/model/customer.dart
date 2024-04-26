class Customer {
  String? id;
  String nama;
  String email;
  String noTelp;
  String tglLahir;
  String? poin;
  String? saldo;

  Customer({
    this.id,
    required this.nama,
    required this.email,
    required this.noTelp,
    required this.tglLahir,
    this.poin,
    this.saldo
  });

  factory Customer.fromApi(Map<String, dynamic> data){
    return Customer(
      id: data['id_customer'].toString(), 
      nama: data['nama_customer'], 
      email: data['email_customer'], 
      noTelp: data['no_telp'], 
      tglLahir: data['tanggal_lahir'],
      poin: data['poin'],
      saldo: data['saldo']
    );
  }
}