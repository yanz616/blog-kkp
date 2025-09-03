import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/presentation/views/desktop/home/home_page.dart';
import 'package:fe/presentation/views/desktop/home/my_activity_page.dart';
import 'package:fe/presentation/views/desktop/home/profile_page.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';

class DesktopMainScaffold extends StatefulWidget {
  const DesktopMainScaffold({super.key});

  @override
  State<DesktopMainScaffold> createState() => _DesktopMainScaffoldState();
}

class _DesktopMainScaffoldState extends State<DesktopMainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DesktopHomePage(),
    DesktopMyActivitiesPage(),
    DesktopProfilePage(),
  ];

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = _selectedIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.lightBlue : AppColors.white,
      ),
      title: PoppinText(
        text: label,
        styles: StyleText(
          color: isSelected ? AppColors.lightBlue : AppColors.white,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.white,
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar Navigasi
          Container(
            width: 250,
            color: AppColors.oldBlue,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: PoppinText(
                    text: 'IKP Magang Blog',
                    styles: StyleText(
                      color: AppColors.white,
                      size: 24,
                      weight: AppWeights.bold,
                    ),
                  ),
                ),
                _buildNavItem(index: 0, icon: Icons.home, label: 'Beranda'),
                _buildNavItem(
                  index: 1,
                  icon: Icons.my_library_books,
                  label: 'Kegiatanku',
                ),
                _buildNavItem(index: 2, icon: Icons.person, label: 'Profil'),
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
