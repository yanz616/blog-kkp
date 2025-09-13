import 'package:fe/data/helpers/date_time_helper.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:gap/gap.dart';

class MyActivityCard extends StatefulWidget {
  final String title;
  final String date;
  final String? imageUrl;
  final String author;
  final String? avatar;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MyActivityCard({
    super.key,
    required this.title,
    required this.date,
    this.imageUrl,
    required this.author,
    this.avatar,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<MyActivityCard> createState() => _MyActivityCardState();
}

class _MyActivityCardState extends State<MyActivityCard> {
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar dengan overlay gradient
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffEDE9F0),
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
                                  color: Colors.grey,
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
                Gap(8),
                // Bagian bawah: avatar, author, date, dan action button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: widget.avatar != null
                            ? NetworkImage(widget.avatar!)
                            : null,
                        child: widget.avatar == null
                            ? const Icon(Icons.person, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PoppinText(
                              text: widget.author,
                              styles: StyleText(
                                size: 14,
                                weight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            PoppinText(
                              text: DateTimeHelper.formatLongDate(widget.date),
                              styles: StyleText(size: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      // Tombol aksi (edit & delete)
                      Row(
                        children: [
                          IconButton(
                            onPressed: widget.onEdit,
                            icon: const Icon(Icons.edit, color: Colors.amber),
                          ),
                          IconButton(
                            onPressed: widget.onDelete,
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
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
