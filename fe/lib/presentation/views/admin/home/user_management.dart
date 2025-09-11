import 'package:fe/data/models/user/user.dart';
import 'package:fe/presentation/blocs/admin/admin_bloc.dart';
import 'package:fe/presentation/blocs/admin/admin_event.dart';
import 'package:fe/presentation/blocs/admin/admin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  // Set untuk menyimpan indeks pengguna yang dipilih
  final Set<int> _selectedRows = {};
  @override
  void initState() {
    context.read<AdminBloc>().add(FetchUsers());
    super.initState();
  }

  // void _deleteSelectedUsers() {
  //   // Buat daftar indeks yang akan dihapus, urutkan dari yang terbesar agar tidak mengganggu indeks saat dihapus
  //   final List<int> sortedIndices = _selectedRows.toList()
  //     ..sort((a, b) => b.compareTo(a));

  //   setState(() {
  //     for (final index in sortedIndices) {
  //       users.removeAt(index);
  //     }
  //     _selectedRows.clear(); // Bersihkan pilihan setelah dihapus
  //   });

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('${sortedIndices.length} pengguna berhasil dihapus!'),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is LoadingAdminState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is LoadedUsers) {
            final List<User> users = state.users;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // ... (Header halaman sama seperti sebelumnya) ...
                  const Text(
                    'Manajemen Pengguna',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Kelola akun peserta magang.',
                    style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
                  ),
                  const SizedBox(height: 32.0),

                  // Tabel Pengguna
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
                      columns: [
                        DataColumn(
                          label: Text(
                            'Nama Peserta',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Tanggal Gabung',
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
                      rows: List.generate(users.length, (index) {
                        final user = users[index];
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
                            DataCell(Text(user.username)),
                            DataCell(Text(user.email)),
                            DataCell(Text(user.createdAt!)),
                            DataCell(
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Konfirmasi Hapus'),
                                      content: const Text(
                                        'Apakah Anda yakin ingin menghapus pengguna ini?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('Batal'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              users.removeAt(index);
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
            );
          }
          if (state is FailureAdminState) {
            return Center(child: Text(state.message));
          }
          return SizedBox.shrink(
            child: Center(child: Text("ini Di dalam SizedBox")),
          );
        },
      ),
    );
  }
}
