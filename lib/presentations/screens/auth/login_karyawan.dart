  import 'package:flutter/material.dart';
  import 'package:hexcolor/hexcolor.dart';
  import 'package:frontend_mobile/data/repository/auth_repo.dart';
  import 'package:shared_preferences/shared_preferences.dart';

class LoginKaryawan extends StatefulWidget {
  const LoginKaryawan({super.key});

  @override
  State<LoginKaryawan> createState() => _LoginKaryawanState();
}

class _LoginKaryawanState extends State<LoginKaryawan> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void login(String email, String password) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var acceptedRolse =[
        'Admin',
        'Manager Operational',
        'Owner'
      ];
      try{
        var data = await AuthRepository().loginKaryawan(email, password);
        String token = data['token'];
        String role = data['role'];
        if(!acceptedRolse.contains(role)){
          Navigator.pushNamed(context, '/loginKaryawan');
        }
        prefs.setString('token', token);
        prefs.setString('role', role);
        if(role == 'Admin'){
          Navigator.pushReplacementNamed(context, '/admin');
        }else if(role == 'Manager Operational'){
          Navigator.pushReplacementNamed(context, '/managerOperational');
        }else if(role == 'Owner'){
          Navigator.pushReplacementNamed(context, '/owner');
        }
      }catch(e){
        print(e);
      }
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Atma Kitchen",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text("Login Karyawan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: 'Email', border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: HexColor("#65390E")),
                              ),
                              floatingLabelStyle: TextStyle(color: HexColor("#65390E"))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: HexColor("#65390E")),
                              ),
                              floatingLabelStyle: TextStyle(color: HexColor("#65390E"))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 32.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              login(emailController.text,
                                  passwordController.text);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            decoration: BoxDecoration(
                                color: HexColor("#65390E"),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ))),
        ],
      ),
    );
  }
}