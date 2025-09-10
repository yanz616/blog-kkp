import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/presentation/blocs/posts/post_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_event.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';
import 'package:fe/presentation/views/desktop/home/activity_detail_page.dart';
import 'package:fe/presentation/views/desktop/home/add_activity.dart';
import 'package:fe/presentation/views/desktop/home/edit_activity.dart';
import 'package:fe/presentation/widgets/my_activity_card.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DesktopMyActivitiesPage extends StatefulWidget {
  const DesktopMyActivitiesPage({super.key});

  @override
  State<DesktopMyActivitiesPage> createState() =>
      _DesktopMyActivitiesPageState();
}

class _DesktopMyActivitiesPageState extends State<DesktopMyActivitiesPage> {
  // void _deleteActivity(int index) {

  @override
  void initState() {
    context.read<PostBloc>().add(FetchMyPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // context.read<PostBloc>().add(FetchMyPosts());
    return Column(
      children: [
        AppBar(
          title: PoppinText(
            text: 'Kegiatanku',
            styles: StyleText(
              color: AppColors.darkGray,
              weight: AppWeights.bold,
            ),
          ),
          backgroundColor: AppColors.lightBlue,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle, color: AppColors.oldBlue),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DesktopAddActivityPage(),
                  ),
                );
              },
            ),
          ],
        ),
        const Gap(16.0),
        BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PostsLoaded) {
              final posts = state.myPosts; // hanya ambil postingan user login
              if (posts.isEmpty) {
                return Center(
                  child: PoppinText(
                    text: "Anda Tidak Memiliki Kegiatan",
                    styles: StyleText(size: 30),
                  ),
                );
              }
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.9,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 18.0,
                        ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final items = posts[index];
                      return MyActivityCard(
                        title: items.title,
                        date: items.createdAt!,
                        imageUrl: items.image,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      DesktopActivityDetailPage(post: items),
                            ),
                          );
                        },
                        onEdit: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => const DesktopEditActivityPage(),
                            ),
                          );
                        },
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: PoppinText(
                                  text: 'Konfirmasi Hapus',
                                  styles: StyleText(),
                                ),
                                content: PoppinText(
                                  text:
                                      'Apakah Anda yakin ingin menghapus kegiatan ini?',
                                  styles: StyleText(),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(dialogContext).pop(),
                                    child: PoppinText(
                                      text: 'Batal',
                                      styles: StyleText(),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // spanggil event DeletePost
                                      Navigator.of(dialogContext).pop();
                                    },
                                    child: PoppinText(
                                      text: 'Hapus',
                                      styles: StyleText(
                                        color: AppColors.crimson,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            }
            if (state is PostsFailure) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
