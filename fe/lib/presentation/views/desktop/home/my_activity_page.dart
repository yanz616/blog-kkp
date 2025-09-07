import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/presentation/views/desktop/home/activity_detail_page.dart';
import 'package:fe/presentation/views/desktop/home/add_activity.dart';
import 'package:fe/presentation/views/desktop/home/edit_activity.dart';
import 'package:fe/presentation/widgets/my_activity_card.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// Contoh data dummy untuk simulasi
// class Activity {
//   final String title;
//   final String date;
//   Activity(this.title, this.date);
// }

class DesktopMyActivitiesPage extends StatefulWidget {
  const DesktopMyActivitiesPage({super.key});

  @override
  State<DesktopMyActivitiesPage> createState() =>
      _DesktopMyActivitiesPageState();
}

class _DesktopMyActivitiesPageState extends State<DesktopMyActivitiesPage> {
  // void _deleteActivity(int index) {
  //   setState(() {
  //     _activities.removeAt(index);
  //   });
  //   // memanggil API untuk menghapus data di server
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: PoppinText(
  //         text: 'Kegiatan berhasil dihapus!',
  //         styles: StyleText(),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: PoppinText(
            text: 'Kegiatanku',
            styles: StyleText(
              color: AppColors.darkGray,
              weight: AppWeights.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle, color: AppColors.lightBlue),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DesktopAddActivityPage(),
                  ),
                );
              },
            ),
          ],
        ),
        const Gap(16.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 18.0,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return MyActivityCard(
                  title: "Rapat Dinas",
                  date: "26 Agustus 2025",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DesktopActivityDetailPage(),
                      ),
                    );
                  },
                  onEdit: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DesktopEditActivityPage(),
                      ),
                    );
                  },
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: PoppinText(
                            text: 'Konfirmasi Hapus',
                            styles: StyleText(),
                          ),
                          content: PoppinText(
                            text:
                                'Apakah Anda yakin ingin menghapus kegiatan ini?',
                            styles: StyleText(),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
                              child: PoppinText(
                                text: 'Batal',
                                styles: StyleText(),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // _deleteActivity(index);
                                Navigator.of(dialogContext).pop();
                              },
                              child: PoppinText(
                                text: 'Hapus',
                                styles: StyleText(color: AppColors.crimson),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
