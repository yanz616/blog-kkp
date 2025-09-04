import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/presentation/views/desktop/home/edit_profile_page.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DesktopProfilePage extends StatelessWidget {
  const DesktopProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CircleAvatar(
              radius: 70,
              backgroundColor: AppColors.oldBlue,
              child: Icon(Icons.person, size: 80, color: Colors.white),
            ),
            const Gap(24.0),
            PoppinText(
              text: 'Nama Lengkap Peserta',
              styles: StyleText(
                size: 24,
                weight: FontWeight.bold,
                color: AppColors.darkGray,
              ),
            ),
            const Gap(8.0),
            PoppinText(
              text: 'email.peserta@example.com',
              styles: StyleText(size: 16, color: AppColors.mediumGray),
            ),
            const Gap(40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: PoppinText(
                  text: 'Edit Profil',
                  styles: StyleText(size: 18, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
