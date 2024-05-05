import 'package:flutter/material.dart';
import 'package:frontend_mobile/presentations/screens/karyawan/home_karyawan.dart';
import 'package:hexcolor/hexcolor.dart';

class NavigationOwner extends StatefulWidget {
  const NavigationOwner({super.key});

  @override
  State<NavigationOwner> createState() => _NavigationOwnerState();
}

class _NavigationOwnerState extends State<NavigationOwner> {
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
          children: const [
            HomeScreenKaryawan(),
            Placeholder(), // GANTI
            Placeholder() // GANTI
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: HexColor("#65390E"),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        // GANTI
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Owner Test',
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
