import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:frontend_mobile/data/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    AuthRepository authRepository = AuthRepository();
    var acceptedRole = ['Admin', 'Manager Operational', 'Owner'];

    Future<bool> isCustomer(String email, String password) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      try{
        var response = await authRepository.loginCustomer(email, password);
        String? token = response['token'];
        if(token != null){
          prefs.setString('token', token);
          return true;
        }
        return false;
      }catch(error){
        print(error);
        return false;
      }
    }

  Future<bool> isKaryawan(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      var response = await authRepository.loginKaryawan(email, password);
      String? token = response['token'];
      String? role = response['role'];
      if(token != null && role != null && acceptedRole.contains(role)){
        prefs.setString('token', token);
        prefs.setString('role', role);
        return true;
      }
      return false;
    }catch(error){
      print(error);
      return false;
    }
  }

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Atma Kitchen",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text("Masukan email dan password untuk login",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16.0),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                  child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: TextFormField(
                              cursorColor: HexColor("#65390E"),
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: HexColor("#65390E")),
                                  ),
                                  floatingLabelStyle:
                                      TextStyle(color: HexColor("#65390E"))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: TextFormField(
                              cursorColor: HexColor("#65390E"),
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: HexColor("#65390E")),
                                  ),
                                  floatingLabelStyle:
                                      TextStyle(color: HexColor("#65390E"))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 32.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                 if(await isCustomer(emailController.text, passwordController.text)){
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Row(
                                      children: [
                                        Icon(Icons.check,
                                            color: Color(0xFFFFFFFF)),
                                        SizedBox(width: 8.0),
                                        Text(
                                          'Berhasil Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: Colors.greenAccent,
                                    duration: const Duration(seconds: 3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                    if(!context.mounted) return;
                                    Navigator.pushReplacementNamed(context, '/customer');
                                  }else if(await isKaryawan(emailController.text, passwordController.text)){
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    String? role = prefs.getString('role');
                                    if(role == 'Admin'){
                                      if(!context.mounted) return;
                                      Navigator.pushReplacementNamed(context, '/admin');
                                    }else if(role == 'Manager Operational'){
                                      if(!context.mounted) return;
                                      Navigator.pushReplacementNamed(context, '/managerOperational');
                                    }else if(role == 'Owner'){
                                      if(!context.mounted) return;
                                      Navigator.pushReplacementNamed(context, '/owner');
                                    }
                                  }else{
                                    if(!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Row(
                                          children: [
                                            Icon(Icons.error, color: Color(0xFFFFFFFF)),
                                            SizedBox(width: 8.0),
                                            Text('Email atau Password salah',
                                              style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 16
                                              ),
                                            ),
                                          ],
                                        ),
                                        backgroundColor: Colors.redAccent,
                                        duration: const Duration(seconds: 3),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                        behavior: SnackBarBehavior.floating,
                                        
                                      )
                                    );
                                    print('Login gagal');
                                  }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: HexColor("#65390E"),
                                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                  minimumSize: Size(double.infinity, 50.0)
                              ),
                              child: const Text('Login',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ],
      ),
    );
  }
}
