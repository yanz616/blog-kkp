import 'package:flutter/material.dart';

class PostManagementPage extends StatefulWidget {
  const PostManagementPage({super.key});

  @override
  State<PostManagementPage> createState() => _PostManagementPageState();
}

class _PostManagementPageState extends State<PostManagementPage> {
  // Contoh data dummy untuk simulasi daftar postingan
  // Ganti ini dengan data yang diambil dari backend saat inisialisasi halaman
  final List<Map<String, String>> _posts = [
    {
      'title': 'Rapat Persiapan Proyek',
      'author': 'Rizky Fadilah',
      'date': '2025-09-09',
    },
    {
      'title': 'Pelatihan Flutter Lanjutan',
      'author': 'Maya Putri',
      'date': '2025-09-08',
    },
    {
      'title': 'Studi Kasus UI/UX',
      'author': 'Taufik Hidayat',
      'date': '2025-09-07',
    },
    {
      'title': 'Diskusi Pembangunan Website',
      'author': 'Budi Santoso',
      'date': '2025-09-06',
    },
    {
      'title': 'Analisis Data Proyek',
      'author': 'Nisa Rahmawati',
      'date': '2025-09-05',
    },
  ];

  // Set untuk menyimpan indeks postingan yang dipilih
  final Set<int> _selectedRows = {};

  // Fungsi untuk menghapus semua postingan yang dipilih
  void _deleteSelectedPosts() {
    final List<int> sortedIndices = _selectedRows.toList()
      ..sort((a, b) => b.compareTo(a));

    // ==========================================================
    // DI SINI ADALAH TEMPAT UNTUK FUNGSI HAPUS MASSAL DARI BACKEND
    // Anda bisa membuat fungsi asinkron untuk memanggil API Anda
    // Contoh:
    // Future<void> deletePostsFromApi() async {
    //   try {
    //     for (final index in sortedIndices) {
    //       final postId = _posts[index]['id']; // Asumsi Anda punya ID
    //       await apiService.deletePost(postId);
    //     }
    //     // Setelah berhasil, baru perbarui UI
    //     setState(() {
    //       for (final index in sortedIndices) {
    //         _posts.removeAt(index);
    //       }
    //       _selectedRows.clear();
    //     });
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Postingan berhasil dihapus!')),
    //     );
    //   } catch (e) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Gagal menghapus: $e')),
    //     );
    //   }
    // }
    // ==========================================================

    // Perbarui UI jika penghapusan di backend berhasil
    setState(() {
      for (final index in sortedIndices) {
        _posts.removeAt(index);
      }
      _selectedRows.clear(); // Bersihkan pilihan setelah dihapus
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${sortedIndices.length} postingan berhasil dihapus!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedRows.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _deleteSelectedPosts,
              label: Text('Hapus (${_selectedRows.length})'),
              icon: const Icon(Icons.delete),
              backgroundColor: Colors.red,
            )
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Manajemen Postingan',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Kelola semua postingan kegiatan magang.',
              style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
            ),
            const SizedBox(height: 32.0),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: DataTable(
                showCheckboxColumn: true,
                columns: const [
                  DataColumn(
                    label: Text(
                      'Judul',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Penulis',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Tanggal',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Aksi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: List.generate(_posts.length, (index) {
                  final post = _posts[index];
                  final bool isSelected = _selectedRows.contains(index);

                  return DataRow(
                    selected: isSelected,
                    onSelectChanged: (bool? newBool) {
                      setState(() {
                        if (newBool == true) {
                          _selectedRows.add(index);
                        } else {
                          _selectedRows.remove(index);
                        }
                      });
                    },
                    cells: [
                      DataCell(Text(post['title']!)),
                      DataCell(Text(post['author']!)),
                      DataCell(Text(post['date']!)),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Konfirmasi Hapus'),
                                content: const Text(
                                  'Apakah Anda yakin ingin menghapus postingan ini?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // ===============================================
                                      // TEMPAT UNTUK FUNGSI HAPUS SATU ITEM DARI BACKEND
                                      // Contoh: apiService.deletePost(postId);
                                      // ===============================================
                                      setState(() {
                                        _posts.removeAt(index);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Hapus',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
