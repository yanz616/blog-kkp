import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/presentation/views/desktop/auth/login_page.dart';
import 'package:fe/presentation/views/desktop/home/home_page.dart';
import 'package:fe/presentation/views/desktop/home/my_activity_page.dart';
import 'package:fe/presentation/views/desktop/home/profile_page.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Colors.white.withValues(alpha: 0.15)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.white70),
            const SizedBox(width: 8),
            PoppinText(
              text: label,
              styles: StyleText(
                color: isSelected ? Colors.white : Colors.white70,
                weight: isSelected ? AppWeights.semiBold : AppWeights.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.crimson),
              const Gap(8),
              PoppinText(
                text: 'Konfirmasi Logout',
                styles: StyleText(weight: AppWeights.semiBold),
              ),
            ],
          ),
          content: PoppinText(
            text: 'Apakah Anda yakin ingin Logout?',
            styles: StyleText(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: PoppinText(
                text: 'Batal',
                styles: StyleText(color: AppColors.darkGray),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.crimson,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                if (!mounted) return;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder:
                          (BuildContext context) => const DesktopLoginPage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                });
              },
              child: PoppinText(
                text: 'Logout',
                styles: StyleText(color: AppColors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.oldBlue, AppColors.lightBlue],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo/ikpLogo.png'),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PoppinText(
                          text: 'KKP Blog',
                          styles: StyleText(
                            color: Colors.white,
                            size: 22,
                            weight: AppWeights.bold,
                          ),
                        ),

                        PoppinText(
                          text: 'Blog Kegiatan Magang',
                          styles: StyleText(
                            color: Colors.white,
                            size: 12,
                            weight: AppWeights.light,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),

                _buildNavItem(index: 0, icon: Icons.home, label: 'Beranda'),
                const SizedBox(width: 16),
                _buildNavItem(
                  index: 1,
                  icon: Icons.my_library_books,
                  label: 'Kegiatanku',
                ),
                const SizedBox(width: 16),
                _buildNavItem(index: 2, icon: Icons.person, label: 'Profil'),
                const SizedBox(width: 24),

                // Logout
                InkWell(
                  onTap: _showLogoutDialog,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.logout, color: Colors.white70),
                        SizedBox(width: 8),
                        Text('Keluar', style: TextStyle(color: Colors.white70)),
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
