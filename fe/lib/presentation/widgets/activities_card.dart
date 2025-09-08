import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/data/helpers/date_time_helper.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ActivitiesCard extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String? imageUrl;
  final String? avatar;
  final VoidCallback onTap;

  const ActivitiesCard({
    super.key,
    required this.title,
    required this.author,
    required this.date,
    this.imageUrl,
    required this.avatar,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                            image: NetworkImage(imageUrl!),
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
              const Gap(12),
              PoppinText(
                text: title,
                styles: StyleText(
                  size: 18,
                  weight: FontWeight.bold,
                  color: AppColors.darkGray,
                ),
              ),
              const Gap(4),
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(avatar!)),
                  const Gap(4),
                  PoppinText(
                    text: author,
                    styles: StyleText(size: 14, color: AppColors.mediumGray),
                  ),
                ],
              ),
              const Gap(4),
              PoppinText(
                text: DateTimeHelper.formatLongDate(date),
                styles: StyleText(color: AppColors.mediumGray),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
