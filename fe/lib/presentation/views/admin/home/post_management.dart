import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/presentation/blocs/posts/post_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_event.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  /// Hapus banyak postingan berdasarkan ID yang sudah dichecklist
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
        content: Text('${idsToDelete.length} postingan berhasil dihapus!'),
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
              return const Center(child: Text("Tidak ada Postingan"));
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
                      rows: List.generate(posts.length, (index) {
                        final post = posts[index];
                        final isSelected = _selectedRows.contains(index);

                        return DataRow(
                          selected: isSelected,
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
                            DataCell(Text(post.createdAt ?? "-")),
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
                                            context.read<PostBloc>().add(
                                              DeletePost(post.id),
                                            );
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

          if (state is PostsFailure) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
