import 'package:fe/presentation/views/mobile/home/mobile_home_page.dart';
import 'package:fe/presentation/views/mobile/home/my_activity_page.dart';
import 'package:fe/presentation/views/mobile/home/profile_page.dart';
import 'package:flutter/material.dart';

class MobileMainScaffold extends StatefulWidget {
  const MobileMainScaffold({super.key});

  @override
  State<MobileMainScaffold> createState() => _MobileMainScaffoldState();
}

class _MobileMainScaffoldState extends State<MobileMainScaffold> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const MobileHomePage(),
    const MobileMyActivitiesPage(),
    const MobileProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            label: 'Kegiatanku',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF2196F3),
        unselectedItemColor: const Color(0xFF757575),
        onTap: _onItemTapped,
      ),
    );
  }
}
