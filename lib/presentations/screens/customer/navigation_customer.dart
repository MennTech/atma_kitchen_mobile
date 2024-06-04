import 'package:flutter/material.dart';
import 'package:frontend_mobile/presentations/screens/customer/home_customer.dart';
import 'package:frontend_mobile/presentations/screens/customer/profile_screen.dart';
import 'package:frontend_mobile/presentations/screens/customer/history_screen.dart';
import 'package:frontend_mobile/presentations/screens/customer/pesanan_screen.dart';
import 'package:hexcolor/hexcolor.dart';

class NavigationCustomer extends StatefulWidget {
  const NavigationCustomer({super.key});

  @override
  State<NavigationCustomer> createState() => _NavigationCustomerState();
}

class _NavigationCustomerState extends State<NavigationCustomer> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: const [HomeScreenCustomer(), PesananScreen(), HistoryScreen(), Profile()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: HexColor("#65390E"),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
