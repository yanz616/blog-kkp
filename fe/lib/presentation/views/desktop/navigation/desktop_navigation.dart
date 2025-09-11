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
  final int? index; // nullable

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
    // kalau widget.index null → fallback ke 0
    _selectedIndex = widget.index ?? 0;
  }

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
          // Sidebar
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
                InkWell(
                  onTap:
                      //alert dialog
                      () async {
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
                  child: const ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title: Text(
                      'Keluar',
                      style: TextStyle(color: Colors.white),
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
