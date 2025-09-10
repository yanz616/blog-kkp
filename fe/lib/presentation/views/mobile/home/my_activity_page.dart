import 'package:fe/presentation/views/mobile/home/activity_detail_page.dart';
import 'package:fe/presentation/views/mobile/home/add_edit_activity_page.dart';
import 'package:fe/presentation/widgets/my_activity_card.dart';
import 'package:flutter/material.dart';

// Contoh data dummy
class Activity {
  final String title;
  final String date;
  Activity(this.title, this.date);
}

class MobileMyActivitiesPage extends StatefulWidget {
  const MobileMyActivitiesPage({super.key});

  @override
  State<MobileMyActivitiesPage> createState() => _MobileMyActivitiesPageState();
}

class _MobileMyActivitiesPageState extends State<MobileMyActivitiesPage> {
  // Daftar kegiatan yang akan kita kelola
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kegiatanku',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0D47A1),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _activities.length,
        itemBuilder: (context, index) {
          return MyActivityCard(
            title: _activities[index].title,
            date: _activities[index].date,

            author: '',
            imageUrl: '',
            avatar: '',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MobileActivityDetailPage(),
                ),
              );
            },
            onEdit: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => const AddEditActivityPage(isEditing: true),
                ),
              );
            },
            onDelete: () {
              // Tampilkan dialog konfirmasi
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
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Panggil fungsi hapus jika dikonfirmasi
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
      // Tombol tambah tetap sama
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditActivityPage(isEditing: false),
            ),
          );
        },
        backgroundColor: const Color(0xFF2196F3),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
