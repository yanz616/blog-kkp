import 'package:fe/presentation/views/admin/home/dashboard.dart';
import 'package:fe/presentation/views/admin/home/post_management.dart';
import 'package:fe/presentation/views/admin/home/user_management.dart';
import 'package:flutter/material.dart';

class AdminMainScaffold extends StatefulWidget {
  const AdminMainScaffold({super.key});

  @override
  State<AdminMainScaffold> createState() => _AdminMainScaffoldState();
}

class _AdminMainScaffoldState extends State<AdminMainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AdminDashboardPage(),
    const PostManagementPage(), // Halaman yang akan kita buat selanjutnya
    const UserManagementPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar Navigasi
          Container(
            width: 280,
            color: const Color(0xFF003366), // Biru Tua Diskominfotik
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    'Panel Admin',
                    style: TextStyle(
                      color: Color(0xFFE1AD01), // Emas
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.dashboard, color: Colors.white),
                  title: const Text(
                    'Dasbor',
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: _selectedIndex == 0,
                  selectedTileColor: const Color(
                    0xFFE1AD01,
                  ).withValues(alpha: 0.5),
                  onTap: () => setState(() => _selectedIndex = 0),
                ),
                ListTile(
                  leading: const Icon(Icons.article, color: Colors.white),
                  title: const Text(
                    'Manajemen Postingan',
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: _selectedIndex == 1,
                  selectedTileColor: const Color(
                    0xFFE1AD01,
                  ).withValues(alpha: 0.5),
                  onTap: () => setState(() => _selectedIndex = 1),
                ),
                ListTile(
                  leading: const Icon(Icons.people, color: Colors.white),
                  title: const Text(
                    'Manajemen Pengguna',
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: _selectedIndex == 2,
                  selectedTileColor: const Color(
                    0xFFE1AD01,
                  ).withValues(alpha: 0.5),
                  onTap: () => setState(() => _selectedIndex = 2),
                ),
                const Spacer(),
                const ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text('Keluar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),

          // Area Konten Utama
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: _pages),
          ),
        ],
      ),
    );
  }
}
