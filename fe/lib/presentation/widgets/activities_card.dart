import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ActivitiesCard extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final VoidCallback onTap;

  const ActivitiesCard({
    super.key,
    required this.title,
    required this.author,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        elevation: 2,
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.photo_library,
                    size: 50,
                    color: AppColors.mediumGray,
                  ),
                ),
              ),
              Gap(12),
              PoppinText(
                text: title,
                styles: StyleText(
                  size: 18,
                  weight: FontWeight.bold,
                  color: AppColors.darkGray,
                ),
              ),
              Gap(4),
              PoppinText(
                text: "Oleh : $author",
                styles: StyleText(size: 14, color: AppColors.mediumGray),
              ),
              Gap(4),
              PoppinText(
                text: date,
                styles: StyleText(color: AppColors.mediumGray),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
