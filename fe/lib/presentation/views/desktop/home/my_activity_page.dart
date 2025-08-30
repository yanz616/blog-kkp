import 'package:fe/presentation/views/desktop/home/activity_detail_page.dart';
import 'package:fe/presentation/views/desktop/home/add_edit_activity_page.dart';
import 'package:fe/presentation/widgets/my_activity_card.dart';
import 'package:flutter/material.dart';

// Contoh data dummy untuk simulasi
class Activity {
  final String title;
  final String date;
  Activity(this.title, this.date);
}

class DesktopMyActivitiesPage extends StatefulWidget {
  const DesktopMyActivitiesPage({super.key});

  @override
  State<DesktopMyActivitiesPage> createState() =>
      _DesktopMyActivitiesPageState();
}

class _DesktopMyActivitiesPageState extends State<DesktopMyActivitiesPage> {
  final List<Activity> _activities = [
    Activity('Rapat Koordinasi Mingguan', '25 Agustus 2025'),
    Activity('Presentasi Proyek Akhir', '28 Agustus 2025'),
    Activity('Pelatihan Desain UI/UX', '01 September 2025'),
  ];

  void _deleteActivity(int index) {
    setState(() {
      _activities.removeAt(index);
    });
    // Di sini Anda juga bisa memanggil API untuk menghapus data di server
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Kegiatan berhasil dihapus!')));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text(
            'Kegiatanku',
            style: TextStyle(
              color: Color(0xFF212121),
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle, color: Color(0xFF2196F3)),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const DesktopAddEditActivityPage(isEditing: false),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                return MyActivityCard(
                  title: _activities[index].title,
                  date: _activities[index].date,
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
                        builder: (context) =>
                            const DesktopAddEditActivityPage(isEditing: true),
                      ),
                    );
                  },
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: const Text('Konfirmasi Hapus'),
                          content: const Text(
                            'Apakah Anda yakin ingin menghapus kegiatan ini?',
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteActivity(index);
                                Navigator.of(dialogContext).pop();
                              },
                              child: const Text(
                                'Hapus',
                                style: TextStyle(color: Colors.red),
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
