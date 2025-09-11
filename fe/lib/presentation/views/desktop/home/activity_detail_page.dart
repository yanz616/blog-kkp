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
          child: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.white, // Bersih tanpa abu-abu
      body: Padding(
        padding: const EdgeInsets.all(32), // lebih lega
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 900,
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Hero Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 420,
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

                  const Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(
                          post.author!.avatar.toString(),
                        ),
                      ),
                      const Gap(12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PoppinText(
                            text: post.author!.username,
                            styles: StyleText(
                              size: 16,
                              weight: AppWeights.semiBold,
                              color: AppColors.darkGray,
                            ),
                          ),
                          const Gap(2),
                          PoppinText(
                            text: DateTimeHelper.formatDateTimeLong(
                              post.createdAt!,
                            ),
                            styles: StyleText(
                              size: 14,
                              color: AppColors.mediumGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Author + Date
                  const Gap(40),
                  // Judul
                  PoppinText(
                    text: post.title,
                    styles: StyleText(
                      size: 36,
                      weight: AppWeights.bold,
                      color: AppColors.darkGray,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Gap(24),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 750),
                    child: QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                        controller: controller,
                      ),
                    ),
                  ),
                  // Deskripsi
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
