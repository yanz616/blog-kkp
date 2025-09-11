import 'package:fe/presentation/views/admin/widgets/statistic_card.dart';
import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header Halaman
          const Text(
            'Dasbor Admin',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003366), // Biru Tua
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Panel Administrasi Jurnal Kegiatan Magang Diskominfotik NTB',
            style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
          ),
          const SizedBox(height: 32.0),

          // Baris Kartu Statistik
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StatisticCard(
                title: 'Total Peserta Magang',
                value: '125',
                icon: Icons.people,
                color: Color(0xFF003366), // Biru Tua
              ),
              StatisticCard(
                title: 'Total Postingan',
                value: '450',
                icon: Icons.article,
                color: Color(0xFFE1AD01), // Emas
              ),
              StatisticCard(
                title: 'Postingan Aktif',
                value: '450',
                icon: Icons.check_circle,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 32.0),

          // Bagian Postingan Terbaru (sudah disesuaikan)
          const Text(
            'Postingan Terbaru',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003366), // Biru Tua
            ),
          ),
          const SizedBox(height: 16.0),
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
              columns: const [
                DataColumn(label: Text('Judul')),
                DataColumn(label: Text('Penulis')),
                DataColumn(label: Text('Tanggal')),
                DataColumn(label: Text('Status')),
              ],
              rows: [
                DataRow(
                  cells: [
                    const DataCell(Text('Rapat Persiapan Proyek')),
                    const DataCell(Text('Rizky Fadilah')),
                    const DataCell(Text('2025-09-09')),
                    DataCell(
                      Chip(
                        label: const Text(
                          'Aktif',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green[400],
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('Pelatihan Flutter Lanjutan')),
                    const DataCell(Text('Maya Putri')),
                    const DataCell(Text('2025-09-08')),
                    DataCell(
                      Chip(
                        label: const Text(
                          'Aktif',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green[400],
                      ),
                    ),
                  ],
                ),
                // Tambahkan lebih banyak DataRow di sini
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk Kartu Statistik (Sudah diperbarui warnanya)
