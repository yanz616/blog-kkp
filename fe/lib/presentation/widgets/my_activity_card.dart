import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/data/helpers/date_time_helper.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyActivityCard extends StatelessWidget {
  final String title;
  final String date;
  final String? imageUrl;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MyActivityCard({
    super.key,
    required this.title,
    required this.date,
    this.imageUrl,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(8),
                  image:
                      imageUrl != null
                          ? DecorationImage(
                            image: NetworkImage(imageUrl!.trim()),
                            fit: BoxFit.cover,
                          )
                          : null,
                ),
                child:
                    imageUrl == null
                        ? const Center(
                          child: Icon(
                            Icons.photo_library,
                            size: 50,
                            color: AppColors.mediumGray,
                          ),
                        )
                        : null,
              ),

              // konten utama
              PoppinText(
                text: title,
                styles: StyleText(size: 16, weight: AppWeights.bold),
              ),
              const Gap(4),
              PoppinText(
                text: DateTimeHelper.formatLongDate(date),
                styles: StyleText(size: 14, color: AppColors.mediumGray),
              ),
              const Gap(12),
              // tombol aksi
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, color: AppColors.amber),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete, color: AppColors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
