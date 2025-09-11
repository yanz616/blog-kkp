import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/utils/local_storage.dart';
import 'package:fe/data/helpers/date_time_helper.dart';
import 'package:fe/data/models/user/user.dart';
import 'package:fe/presentation/views/desktop/home/edit_profile_page.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DesktopProfilePage extends StatefulWidget {
  const DesktopProfilePage({super.key});

  @override
  State<DesktopProfilePage> createState() => _DesktopProfilePageState();
}

class _DesktopProfilePageState extends State<DesktopProfilePage> {
  User? userData;

  Future<void> loadUserData() async {
    final token = await LocalStorage.getString() ?? "";
    final id = await LocalStorage.getId() ?? 0;
    final username = await LocalStorage.getUsername() ?? "";
    final email = await LocalStorage.getEmail() ?? "";
    final avatar = await LocalStorage.getAvatar() ?? "";
    final created = await LocalStorage.getCreated() ?? "";
    final isAdmin = await LocalStorage.getIsAdmin() ?? false;

    if (!mounted) return;

    setState(() {
      userData = User(
        id: id,
        username: username,
        email: email,
        avatar: avatar,
        token: token,
        createdAt: created,
        isAdmin: isAdmin,
      );
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Avatar dengan border gradient tipis
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.lightBlue, Color(0xFF50E3C2)],
                ),
              ),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(userData!.avatar.toString()),
              ),
            ),

            const Gap(28.0),

            // Username
            PoppinText(
              text: userData!.username,
              styles: StyleText(
                size: 26,
                weight: FontWeight.bold,
                color: AppColors.darkGray,
              ),
            ),

            const Gap(10.0),

            // Email
            PoppinText(
              text: userData!.email,
              styles: StyleText(
                size: 16,
                color: AppColors.mediumGray,
              ),
            ),

            const Gap(6.0),

            // Tanggal join
            PoppinText(
              text:
                  "Bergabung pada: ${DateTimeHelper.formatLongDate(userData?.createdAt)}",
              styles: StyleText(
                size: 14,
                color: AppColors.mediumGray,
              ),
            ),

            const Gap(40),

            // Tombol Edit Profil
            SizedBox(
              width: double.infinity,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditProfilePage(userData: userData),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ).copyWith(
                    overlayColor: WidgetStateProperty.all(
                      AppColors.lightBlue.withOpacity(0.85),
                    ),
                  ),
                  child: PoppinText(
                    text: 'Edit Profil',
                    styles: StyleText(
                      size: 18,
                      color: AppColors.white,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
