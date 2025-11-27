import 'dart:convert';

import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/data/helpers/date_time_helper.dart';
import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gap/gap.dart';

class DesktopActivityDetailPage extends StatelessWidget {
  final PostModel post;

  const DesktopActivityDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final doc = Document.fromJson(jsonDecode(post.content));
    final controller = QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 16, left: 12),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 1200,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Judul artikel
                  PoppinText(
                    text: post.title,
                    styles: StyleText(
                      size: 36,
                      weight: AppWeights.bold,
                      color: AppColors.darkGray,
                    ),
                  ),

                  const Gap(12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                post.author!.avatar ?? "https://picsum.photos/80/80",
                height: 48,
                width: 48,
                fit: BoxFit.cover,
              ),
            ),

                  // Author + Date
                  PoppinText(
                    text:
                        "By ${post.author!.username} · ${DateTimeHelper.formatDateTimeLong(post.createdAt!)}",
                    styles: StyleText(size: 16, color: AppColors.mediumGray),
                  ),

                  const Gap(32),

                  // Hero Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 560,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.lightGray,
                        image:
                            post.image != null
                                ? DecorationImage(
                                  image: NetworkImage(post.image!),
                                  fit: BoxFit.cover,
                                )
                                : null,
                      ),
                      child:
                          post.image == null
                              ? const Center(
                                child: Icon(
                                  Icons.photo_library_outlined,
                                  size: 80,
                                  color: AppColors.mediumGray,
                                ),
                              )
                              : null,
                    ),
                  ),

                  const Gap(32),

                  // Isi Artikel
                  QuillEditor.basic(controller: controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
