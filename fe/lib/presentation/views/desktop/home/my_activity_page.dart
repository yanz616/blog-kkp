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
  @override
  void initState() {
    context.read<PostBloc>().add(FetchMyPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: PoppinText(
          text: 'Kegiatanku',
          styles: StyleText(
            size: 24,
            weight: AppWeights.bold,
            color: AppColors.darkGray,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: AppColors.oldBlue,
              size: 28,
            ),
            tooltip: "Tambah Aktivitas",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DesktopAddActivityPage(),
                ),
              );
            },
          ),
          const Gap(8),
        ],
      ),
      backgroundColor: Colors.white, // lebih clean & elegan
      body: Column(
        children: [
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is PostsLoaded) {
                final posts = state.myPosts;
                if (posts.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.event_busy,
                            size: 80,
                            color: AppColors.darkGray,
                          ),
                          const Gap(16),
                          PoppinText(
                            text: "Anda belum memiliki kegiatan",
                            styles: StyleText(
                              size: 22,
                              color: AppColors.darkGray,
                              weight: AppWeights.semiBold,
                            ),
                          ),
                          const Gap(8),
                          PoppinText(
                            text: "Mulai dengan menambahkan aktivitas baru",
                            styles: StyleText(
                              size: 16,
                              color: AppColors.darkGray,
                            ),
                          ),
                        ],
                      ),
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
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 18.0,
                            mainAxisExtent: 460,
                          ),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final items = posts[index];
                        return MyActivityCard(
                          title: items.title,
                          date: items.createdAt!,
                          imageUrl: items.image,
                          avatar: items.author!.avatar,
                          author: items.author!.username,
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
                                    (context) => DesktopEditActivityPage(
                                      postData: items,
                                    ),
                              ),
                            );
                          },
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: Row(
                                    children: [
                                      const Icon(
                                        Icons.warning_amber_rounded,
                                        color: AppColors.crimson,
                                      ),
                                      const Gap(8),
                                      PoppinText(
                                        text: 'Konfirmasi Hapus',
                                        styles: StyleText(
                                          weight: AppWeights.semiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: PoppinText(
                                    text:
                                        'Apakah Anda yakin ingin menghapus kegiatan ini?',
                                    styles: StyleText(),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed:
                                          () =>
                                              Navigator.of(dialogContext).pop(),
                                      child: PoppinText(
                                        text: 'Batal',
                                        styles: StyleText(
                                          color: AppColors.darkGray,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.crimson,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        context.read<PostBloc>().add(
                                          DeletePost(items.id),
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Hapus'),
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
      ),
    );
  }
}
