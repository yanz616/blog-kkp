import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/data/helpers/date_time_helper.dart';
import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DesktopActivityDetailPage extends StatelessWidget {
  final PostModel post;
  final AuthorModel? user;

  const DesktopActivityDetailPage({super.key, required this.post, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
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
                      image: DecorationImage(
                        image: NetworkImage(post.image ?? "Tidak Ada Image"),
                        fit: BoxFit.cover,
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
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                post.author.avatar!,
                              ),
                            ),
                            const Gap(10),
                            PoppinText(
                              text:
                                  post.author.username == user!.username
                                      ? "Anda"
                                      : post.author.username,
                              styles: StyleText(
                                size: 18,
                                weight: AppWeights.semiBold,
                                color: AppColors.mediumGray,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const Gap(10.0),
                        // Tanggal
                        PoppinText(
                          text: DateTimeHelper.formatDateTimeLong(
                            post.createdAt!,
                          ),
                          styles: StyleText(
                            size: 18,
                            color: AppColors.mediumGray,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(20.0),
                        // Deskripsi
                        PoppinText(
                          text: post.content,
                          styles: StyleText(
                            size: 18,
                            color: AppColors.darkGray,
                          ),
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
      ),
    );
  }
}
