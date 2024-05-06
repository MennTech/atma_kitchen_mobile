import 'package:flutter/material.dart';
import 'package:frontend_mobile/presentations/screens/customer/navigation_customer.dart';
import 'package:frontend_mobile/presentations/screens/home_screen.dart';
import 'package:frontend_mobile/presentations/screens/customer/profile_screen.dart';
import 'package:frontend_mobile/presentations/routes/routes.dart';
import 'package:frontend_mobile/presentations/screens/auth/login_customer.dart';
import 'package:frontend_mobile/presentations/screens/auth/login_karyawan.dart';
import 'package:frontend_mobile/presentations/screens/karyawan/navigation_admin.dart';
import 'package:frontend_mobile/presentations/screens/karyawan/navigation_mo.dart';
import 'package:frontend_mobile/presentations/screens/karyawan/navigation_owner.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      routes: {
        Routes.profile: (context) => const Profile(),
        Routes.home: (context) => const HomeScreen(),
        Routes.loginCustomer: (context) => const LoginCustomer(),
        Routes.loginKaryawan: (context) => const LoginKaryawan(),
        Routes.customer: (context) => const NavigationCustomer(),
        Routes.admin: (context) => const NavigationAdmin(),
        Routes.managerOperational: (context) => const NavigationMO(),
        Routes.owner: (context) => const NavigationOwner(),
        },
      // home: Scaffold(
      //   body: Center(
      //     child: Text('Hello World!'),
      //   ),
      // ),
     );
  }
}
