import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:frontend_mobile/data/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCustomer extends StatefulWidget {
  const LoginCustomer({super.key});

  @override
  State<LoginCustomer> createState() => _LoginCustomerState();
}

class _LoginCustomerState extends State<LoginCustomer> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    AuthRepository authRepository = AuthRepository();

    void login(String email, String password) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      try{
        var data = await authRepository.loginCustomer(email, password);
        String token = data['token'];

        prefs.setString('token', token);
        Navigator.pushReplacementNamed(context, '/customer');
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
          const Text("Masukan email dan password untuk login",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16.0),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: 'Email', border: const OutlineInputBorder(),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: const OutlineInputBorder(),
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
                      // lupa password text button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                // navigate to lupa password screen
                              },
                              child: Text(
                                'Lupa Password?',
                                style: TextStyle(
                                  color: HexColor("#65390E"),
                                ),
                              ),
                            ),
                          ], 
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              login(emailController.text, passwordController.text);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            decoration: BoxDecoration(
                                color: HexColor("#65390E"),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: const Text(
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
