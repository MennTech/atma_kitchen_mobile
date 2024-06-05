import 'package:flutter/material.dart';
import 'package:frontend_mobile/data/repository/saldo_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TarikSaldoScreen extends StatefulWidget {
  const TarikSaldoScreen({Key? key}) : super(key: key);

  @override
  _TarikSaldoScreenState createState() => _TarikSaldoScreenState();
}

class _TarikSaldoScreenState extends State<TarikSaldoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nominalController = TextEditingController();
  final _nomorRekeningController = TextEditingController();

  @override
  void dispose() {
    _nominalController.dispose();
    _nomorRekeningController.dispose();
    super.dispose();
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  void _tarikSaldo(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final nominal = double.parse(_nominalController.text);
      final nomorRekening = _nomorRekeningController.text;

      try {
        String token = await getToken();
        var response = await SaldoRepository().tarikSaldo(nomorRekening, nominal, token);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final snackBar = SnackBar(content: Text('Tarik saldo berhasil!'), backgroundColor: Colors.green);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pop();
        } else {
          // Tampilkan pesan error
          final snackBar = SnackBar(content: Text('Tarik saldo gagal: ${response.reasonPhrase}'), backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        // Tampilkan pesan error
        final snackBar = SnackBar(content: Text('Error: $e'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarik Saldo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nominalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nominal',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nominal';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan nominal yang valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nomorRekeningController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nomor Rekening',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nomor rekening';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _tarikSaldo(context),
        child: Icon(Icons.send),
      ),
    );
  }
}

