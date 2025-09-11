import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/presentation/views/desktop/auth/login_page.dart';
import 'package:fe/presentation/views/desktop/home/home_page.dart';
import 'package:fe/presentation/views/desktop/home/my_activity_page.dart';
import 'package:fe/presentation/views/desktop/home/profile_page.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesktopMainScaffold extends StatefulWidget {
  const DesktopMainScaffold({super.key, this.index});
  final int? index;

  @override
  State<DesktopMainScaffold> createState() => _DesktopMainScaffoldState();
}

class _DesktopMainScaffoldState extends State<DesktopMainScaffold> {
  late int _selectedIndex;

  final List<Widget> _pages = const [
    DesktopHomePage(),
    DesktopMyActivitiesPage(),
    DesktopProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index ?? 0;
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white70,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: PoppinText(
                text: label,
                styles: StyleText(
                  color: isSelected ? Colors.white : Colors.white70,
                  weight: isSelected ? AppWeights.semiBold : AppWeights.regular,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar elegan
          Container(
            width: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.oldBlue, AppColors.lightBlue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: PoppinText(
                    text: 'IKP Magang Blog',
                    styles: StyleText(
                      color: Colors.white,
                      size: 22,
                      weight: AppWeights.bold,
                    ),
                  ),
                ),

                // Nav Items
                _buildNavItem(index: 0, icon: Icons.home, label: 'Beranda'),
                _buildNavItem(
                  index: 1,
                  icon: Icons.my_library_books,
                  label: 'Kegiatanku',
                ),
                _buildNavItem(index: 2, icon: Icons.person, label: 'Profil'),

                const Spacer(),

                const Divider(color: Colors.white30, indent: 12, endIndent: 12),

                // Logout
                InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();

                    if (!mounted) return;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const DesktopLoginPage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.logout, color: Colors.white70),
                        SizedBox(width: 12),
                        Text(
                          'Keluar',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Konten utama
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: _pages),
          ),
        ],
      ),
    );
  }
}
