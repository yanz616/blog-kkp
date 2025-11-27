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
  final Set<int> _selectedRows = {};

  @override
  void initState() {
    context.read<AdminBloc>().add(FetchUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is LoadingAdminState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LoadedUsers) {
            final List<User> users = state.users;
            if (users.isEmpty) {
              return const Center(child: Text('User Tidak ada'));
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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

                  // === Tabel Pengguna ===
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
                      showCheckboxColumn: true,
                      headingRowColor: MaterialStateProperty.all(
                        const Color(0xFF1565C0), // biru tua
                      ),
                      headingTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      dataRowHeight: 60,
                      dividerThickness: 0.4,
                      columns: const [
                        DataColumn(label: Text('Nama Peserta')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Tanggal Gabung')),
                        DataColumn(label: Text('Aksi')),
                      ],
                      rows: List.generate(users.length, (index) {
                        final user = users[index];
                        final bool isSelected = _selectedRows.contains(index);

                        return DataRow(
                          selected: isSelected,
                          color: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return index.isEven
                                  ? Colors.white
                                  : const Color(0xFFF5F7FA);
                            },
                          ),
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
                            DataCell(Text(user.createdAt ?? "-")),
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
                                            context
                                                .read<AdminBloc>()
                                                .add(DeleteUser(user.id));
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
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
