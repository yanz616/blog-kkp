import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/presentation/views/admin/home/dashboard.dart';
import 'package:fe/presentation/views/admin/home/post_management.dart';
import 'package:fe/presentation/views/admin/home/user_management.dart';
import 'package:fe/presentation/views/desktop/auth/login_page.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminMainScaffold extends StatefulWidget {
  const AdminMainScaffold({super.key, this.index});
  final int? index;

  @override
  State<AdminMainScaffold> createState() => _AdminMainScaffoldState();
}

class _AdminMainScaffoldState extends State<AdminMainScaffold> {
  late int _selectedIndex;

  final List<Widget> _pages = const [
    AdminDashboardPage(),
    PostManagementPage(),
    UserManagementPage(),
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
          color:
              isSelected
                  ? Colors.white.withValues(alpha: 0.15)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.white70),
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
            width: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.oldBlue, AppColors.lightBlue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 20),
                  child: Row(
                  spacing: 12,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/logo/ikpLogo.png'),
                          ),
                        ),
                      ),
                  
                      PoppinText(
                        text: 'Panel Admin',
                        styles: StyleText(
                          color: Colors.white,
                          size: 22,
                          weight: AppWeights.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Header

                // Nav Items
                _buildNavItem(index: 0, icon: Icons.dashboard, label: 'Dashboard'),
                _buildNavItem(
                  index: 1,
                  icon: Icons.article,
                  label: 'Manajemen Postingan',
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.people,
                  label: 'Manajemen Pengguna',
                ),

                const Spacer(),

                const Divider(color: Colors.white30, indent: 12, endIndent: 12),

                // Logout
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Row(
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                color: AppColors.crimson,
                              ),
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
                              onPressed:
                                  () => Navigator.of(dialogContext).pop(),
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
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.clear();

                                if (!mounted) return;
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (BuildContext context) =>
                                              const DesktopLoginPage(),
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
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.logout, color: Colors.white70),
                        SizedBox(width: 12),
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
