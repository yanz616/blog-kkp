import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/data/helpers/date_time_helper.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ActivitiesCard extends StatefulWidget {
  final String title;
  final String author;
  final String? date;
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
  State<ActivitiesCard> createState() => _ActivitiesCardState();
}

class _ActivitiesCardState extends State<ActivitiesCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: Matrix4.diagonal3Values(
          _isHovered ? 1.03 : 1.0,
          _isHovered ? 1.03 : 1.0,
          1.0,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: _isHovered ? 12 : 4,
          shadowColor: Colors.black.withValues(alpha: 0.15),
          child: InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar dengan overlay gradient
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightGray,
                          image: widget.imageUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(widget.imageUrl!.trim()),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: widget.imageUrl == null
                            ? const Center(
                                child: Icon(
                                  Icons.photo_library_outlined,
                                  size: 60,
                                  color: AppColors.mediumGray,
                                ),
                              )
                            : null,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.6),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: PoppinText(
                          text: widget.title,
                          styles: StyleText(
                            size: 18,
                            weight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(6),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(widget.avatar!),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PoppinText(
                              text: widget.author,
                              styles: StyleText(
                                size: 14,
                                weight: FontWeight.w600,
                                color: AppColors.darkGray,
                              ),
                            ),
                            const Gap(2),
                            PoppinText(
                              text: DateTimeHelper.formatLongDate(widget.date!),
                              styles: StyleText(
                                size: 12,
                                color: AppColors.mediumGray,
                              ),
                            ),
                          ],
                        ),
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
