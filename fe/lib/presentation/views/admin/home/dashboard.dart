import 'package:fe/presentation/blocs/admin/admin_bloc.dart';
import 'package:fe/presentation/blocs/admin/admin_state.dart';
import 'package:fe/presentation/blocs/posts/post_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatisticCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.85), color.withOpacity(0.65)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 36, color: Colors.white),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ganti background jadi gradient soft
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF7FAFC), Color(0xFFE9F1FA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is PostsLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Header Halaman
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Dashboard Admin',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366), // biru tua
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Panel Administrasi Jurnal Kegiatan Magang Diskominfotik NTB',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF757575),
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.dashboard,
                          size: 40,
                          color: Color(0xFF003366),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    Divider(color: Colors.grey[300], thickness: 1),

                    const SizedBox(height: 32.0),

                    // Baris Kartu Statistik
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: BlocBuilder<AdminBloc, AdminState>(
                            builder: (context, adminState) {
                              if (adminState is LoadedUsers) {
                                return StatisticCard(
                                  title: 'Total Peserta Magang',
                                  value: adminState.users.length.toString(),
                                  icon: Icons.people,
                                  color: const Color(0xFF1565C0),
                                );
                              }
                              return const StatisticCard(
                                title: 'Total Peserta Magang',
                                value: '-',
                                icon: Icons.people,
                                color: Color(0xFF1565C0),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatisticCard(
                            title: 'Total Postingan',
                            value: state.allPosts.length.toString(),
                            icon: Icons.article,
                            color: const Color(0xFFE1AD01), // emas
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40.0),

                    // Bagian Postingan Terbaru
                    const Text(
                      'Postingan Terbaru',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003366),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(
                          const Color(0xFF1565C0),
                        ),
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        dataRowHeight: 60,
                        dividerThickness: 0.4,
                        columns: const [
                          DataColumn(label: Text('Judul')),
                          DataColumn(label: Text('Penulis')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Tanggal')),
                        ],
                        rows:
                            state.allPosts.take(5).map((post) {
                              return DataRow(
                                color:
                                    MaterialStateProperty.resolveWith<Color?>((
                                      Set<MaterialState> states,
                                    ) {
                                      // baris ganjil putih, genap abu soft
                                      return state.allPosts.indexOf(post).isEven
                                          ? Colors.white
                                          : const Color(0xFFF5F7FA);
                                    }),
                                cells: [
                                  DataCell(Text(post.title)),
                                  DataCell(Text(post.author!.username)),
                                  DataCell(Text(post.author!.email ?? "-")),
                                  DataCell(
                                    Text(
                                      post.createdAt ?? "-",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                );
              }

              if (state is PostsFailure) {
                return Center(child: Text(state.message));
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
