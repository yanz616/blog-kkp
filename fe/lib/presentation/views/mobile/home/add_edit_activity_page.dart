import 'package:flutter/material.dart';

class AddEditActivityPage extends StatelessWidget {
  final bool isEditing;

  const AddEditActivityPage({super.key, this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Kegiatan' : 'Tambah Kegiatan',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0D47A1), // Biru Tua
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F5F5), // Abu-abu Muda
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            // Input Judul
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Judul Kegiatan',
                prefixIcon: const Icon(Icons.title, color: Color(0xFF0D47A1)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            // Input Deskripsi
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                prefixIcon: const Icon(
                  Icons.description,
                  color: Color(0xFF0D47A1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            // Input Tanggal
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tanggal',
                prefixIcon: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF0D47A1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24.0),
            // Tombol Unggah Foto
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // Logika untuk memilih gambar
                },
                icon: const Icon(Icons.photo_library, color: Color(0xFF0D47A1)),
                label: const Text(
                  'Unggah Foto',
                  style: TextStyle(color: Color(0xFF0D47A1)),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  side: const BorderSide(color: Color(0xFF0D47A1), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Logika untuk menyimpan kegiatan
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  isEditing ? 'Simpan Perubahan' : 'Simpan',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
