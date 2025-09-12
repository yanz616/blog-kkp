import 'package:fe/presentation/blocs/admin/admin_bloc.dart';
import 'package:fe/presentation/blocs/admin/admin_state.dart';
import 'package:fe/presentation/blocs/posts/post_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';
import 'package:fe/presentation/views/admin/widgets/statistic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is PostsLoaded) {
            return Column(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BlocBuilder<AdminBloc, AdminState>(
                      builder: (context, state) {
                        if (state is LoadingAdminState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Sedang Load Value User")),
                          );
                        }
                        if (state is LoadedUsers) {
                          return StatisticCard(
                            title: 'Total Peserta Magang',
                            value: state.users.length.toString(),
                            icon: Icons.people,
                            color: Color(0xFF003366), // Biru Tua
                          );
                        } else if (state is FailureAdminState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Gagal Load Value User")),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    StatisticCard(
                      title: 'Total Postingan',
                      value: state.allPosts.length.toString(),
                      icon: Icons.article,
                      color: Color(0xFFE1AD01), // Emas
                    ),
                    // StatisticCard(
                    //   title: 'Postingan Aktif',
                    //   value: '450',
                    //   icon: Icons.check_circle,
                    //   color: Colors.green,
                    // ),
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
                    rows: state.allPosts.take(5).map((post) {
                      return DataRow(
                        cells: [
                          DataCell(Text(post.title)),
                          DataCell(Text(post.author!.username)),
                          DataCell(Text(post.author!.email ?? "-")),
                          DataCell(Text(post.createdAt ?? "-")),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          } else if (state is PostsFailure) {
            return Center(child: Text(state.message));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

// Widget untuk Kartu Statistik (Sudah diperbarui warnanya)
