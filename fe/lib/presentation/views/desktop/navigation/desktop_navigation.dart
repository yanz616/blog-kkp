import 'package:fe/presentation/views/desktop/home/desktop_home_page.dart';
import 'package:fe/presentation/views/desktop/home/my_activity_page.dart';
import 'package:fe/presentation/views/desktop/home/profile_page.dart';
import 'package:flutter/material.dart';

class DesktopMainScaffold extends StatefulWidget {
  const DesktopMainScaffold({super.key});

  @override
  State<DesktopMainScaffold> createState() => _DesktopMainScaffoldState();
}

class _DesktopMainScaffoldState extends State<DesktopMainScaffold> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const DesktopHomePage(),
    const DesktopMyActivitiesPage(),
    const DesktopProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar Navigasi
          Container(
            width: 250,
            color: const Color(0xFF0D47A1),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    'IKP Magang Blog',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // ListTile untuk Beranda
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: const Text(
                    'Beranda',
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: _selectedIndex == 0,
                  selectedTileColor: const Color(0xFF2196F3),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),
                // ListTile untuk Kegiatanku
                ListTile(
                  leading: const Icon(
                    Icons.my_library_books,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Kegiatanku',
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: _selectedIndex == 1,
                  selectedTileColor: const Color(0xFF2196F3),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
                // ListTile untuk Profil
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.white),
                  title: const Text(
                    'Profil',
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: _selectedIndex == 2,
                  selectedTileColor: const Color(0xFF2196F3),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                ),
                const Spacer(),
                const ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text('Keluar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          // Konten Utama
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: _pages),
          ),
        ],
      ),
    );
  }
}
