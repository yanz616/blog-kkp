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
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.photo_library,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
              Gap(12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff212121),
                ),
              ),
              Gap(4),
              Text(
                "Oleh : $author - $date",
                style: TextStyle(fontSize: 14, color: Color(0xff757575)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
