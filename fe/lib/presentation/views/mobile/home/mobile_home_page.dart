import 'package:fe/presentation/views/mobile/home/activity_detail_page.dart';
import 'package:fe/presentation/widgets/activities_card.dart';
import 'package:flutter/material.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kegiatan Magang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0D47A1),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ActivitiesCard(
            title: 'Rapat Koordinasi Mingguan',
            author: 'Budi Santoso',
            date: '25 Agustus 2025',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MobileActivityDetailPage(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
