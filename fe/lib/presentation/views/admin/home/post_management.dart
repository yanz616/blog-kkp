import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/presentation/blocs/posts/post_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_event.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PostManagementPage extends StatefulWidget {
  const PostManagementPage({super.key});

  @override
  State<PostManagementPage> createState() => _PostManagementPageState();
}

class _PostManagementPageState extends State<PostManagementPage> {
  final Set<int> _selectedRows = {};

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchPosts());
  }

  String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return "-";
    try {
      final date = DateTime.parse(rawDate);
      return DateFormat("dd/MM/yyyy HH:mm").format(date);
    } catch (_) {
      return rawDate;
    }
  }

  void _deleteSelectedPosts(List<PostModel> posts) {
    final idsToDelete = _selectedRows.map((i) => posts[i].id).toList();

    for (final id in idsToDelete) {
      context.read<PostBloc>().add(DeletePost(id));
    }

    setState(() {
      _selectedRows.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(Icons.delete, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              '${idsToDelete.length} postingan berhasil dihapus!',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedRows.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                final bloc = context.read<PostBloc>();
                final state = bloc.state;
                if (state is PostsLoaded) {
                  _deleteSelectedPosts(state.allPosts);
                }
              },
              label: Text('Hapus (${_selectedRows.length})'),
              icon: const Icon(Icons.delete),
              backgroundColor: Colors.red,
            )
          : null,
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PostsLoaded) {
            final posts = state.allPosts;

            if (posts.isEmpty) {
              return const Center(
                child: Text(
                  "Tidak ada Postingan",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 24.0),

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
                        DataColumn(label: Text('Tanggal')),
                        DataColumn(label: Text('Aksi')),
                      ],
                      rows: List.generate(posts.length, (index) {
                        final post = posts[index];
                        final isSelected = _selectedRows.contains(index);

                        return DataRow(
                          selected: isSelected,
                          color:
                              MaterialStateProperty.resolveWith<Color?>((states) {
                            return index.isEven
                                ? Colors.white
                                : const Color(0xFFF5F7FA);
                          }),
                          onSelectChanged: (bool? selected) {
                            setState(() {
                              if (selected == true) {
                                _selectedRows.add(index);
                              } else {
                                _selectedRows.remove(index);
                              }
                            });
                          },
                          cells: [
                            DataCell(Text(post.title)),
                            DataCell(Text(post.author?.username ?? "-")),
                            DataCell(Text(_formatDate(post.createdAt))),
                            DataCell(
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red),
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
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            context.read<PostBloc>().add(
                                                  DeletePost(post.id),
                                                );
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(Icons.delete),
                                          label: const Text('Hapus'),
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

          if (state is PostsFailure) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
