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

  @override
  void initState() {
    _selectedIndex = widget.index ?? 0;
    super.initState();
  }

  final List<Widget> _pages = [
    const AdminDashboardPage(),
    const PostManagementPage(),
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
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
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
                                      builder: (BuildContext context) =>
                                          const DesktopLoginPage(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                });
                              },
                              child: PoppinText(
                                text: "Logout",
                                styles: StyleText(color: AppColors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
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

          // Area Konten Utama
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: _pages),
          ),
        ],
      ),
    );
  }
}
