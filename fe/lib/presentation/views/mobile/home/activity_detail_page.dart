import 'package:flutter/material.dart';

class MobileActivityDetailPage extends StatelessWidget {
  const MobileActivityDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Kegiatan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0D47A1), // Biru Tua
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F5F5), // Abu-abu Muda
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Area Foto Kegiatan
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: const Center(
                child: Icon(Icons.photo, size: 80, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Judul Kegiatan
                  const Text(
                    'Rapat Koordinasi Mingguan Divisi IKP',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Informasi Penulis dan Tanggal
                  const Text(
                    'Oleh: Budi Santoso | 25 Agustus 2025',
                    style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
                  ),
                  const SizedBox(height: 24.0),
                  // Deskripsi Kegiatan
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: TextStyle(fontSize: 16, color: Color(0xFF212121)),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
