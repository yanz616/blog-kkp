import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DesktopActivityDetailPage extends StatelessWidget {
  const DesktopActivityDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 900,
            padding: const EdgeInsets.all(32.0),
            decoration: BoxDecoration(
              color: Colors.white,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Foto Kegiatan (ukuran lebih besar)
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.photo,
                      size: 100,
                      color: AppColors.mediumGray,
                    ),
                  ),
                ),
                const Gap(32.0),
                // Informasi Kegiatan
                SizedBox(
                  width: 700,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PoppinText(
                        text: 'Rapat Koordinasi Mingguan Divisi IKP',
                        styles: StyleText(
                          size: 32,
                          weight: AppWeights.bold,
                          color: AppColors.darkGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(8.0),
                      PoppinText(
                        text: 'Oleh: Budi Santoso',
                        styles: StyleText(
                          size: 18,
                          color: AppColors.mediumGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(8.0),
                      PoppinText(
                        text: '25 Agustus 2025',
                        styles: StyleText(
                          size: 18,
                          color: AppColors.mediumGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(24.0),
                      PoppinText(
                        text:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        styles: StyleText(size: 18, color: AppColors.darkGray),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
