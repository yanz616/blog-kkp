import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DesktopActivityDetailPage extends StatelessWidget {
  final PostModel post;

  const DesktopActivityDetailPage({super.key, required this.post});

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
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: post.image!.isEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            post.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.broken_image,
                              size: 100,
                              color: AppColors.mediumGray,
                            ),
                          ),
                        )
                      : const Center(
                          child: Icon(
                            Icons.photo,
                            size: 100,
                            color: AppColors.mediumGray,
                          ),
                        ),
                ),
                const Gap(32.0),
                SizedBox(
                  width: 700,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul
                      PoppinText(
                        text: post.title,
                        styles: StyleText(
                          size: 32,
                          weight: AppWeights.bold,
                          color: AppColors.darkGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(8.0),

                      // Penulis
                      PoppinText(
                        text: 'Oleh: ${post.authorId}',
                        styles: StyleText(
                          size: 18,
                          color: AppColors.mediumGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(8.0),

                      // Tanggal
                      PoppinText(
                        text: post.createdAt.toString(),
                        styles: StyleText(
                          size: 18,
                          color: AppColors.mediumGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(24.0),

                      // Deskripsi
                      PoppinText(
                        text: post.content,
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
