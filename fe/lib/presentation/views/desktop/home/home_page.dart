import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/presentation/blocs/posts/post_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_event.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';
import 'package:fe/presentation/views/desktop/home/activity_detail_page.dart';
import 'package:fe/presentation/widgets/activities_card.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesktopHomePage extends StatefulWidget {
  const DesktopHomePage({super.key});

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  @override
  void initState() {
    context.read<PostBloc>().add(FetchPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray.withOpacity(0.05),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT CONTENT - scrollable
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HERO BANNER
                  Container(
                    height: 360,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: NetworkImage("https://picsum.photos/1000/400"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PoppinText(
                            text: "Uncover the World's Stories",
                            styles: StyleText(
                              size: 28,
                              weight: AppWeights.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Dive into a collection of insightful articles\nand captivating narratives from diverse voices.",
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {},
                            child: PoppinText(
                              text: "Selamat Datang",
                              styles: StyleText(color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// TITLE
                  PoppinText(
                    text: "Semua Berita",
                    styles: StyleText(
                      size: 22,
                      weight: AppWeights.bold,
                      color: AppColors.darkGray,
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// GRID POSTS
                  BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      if (state is PostsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is PostsLoaded) {
                        final posts = state.allPosts;
                        if (posts.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Center(
                              child: Text("Belum ada postingan tersedia"),
                            ),
                          );
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                          ),
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final item = posts[index];
                            return ActivitiesCard(
                              title: item.title,
                              author: item.author!.username,
                              date: item.createdAt.toString(),
                              avatar: item.author!.avatar,
                              imageUrl: item.image,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DesktopActivityDetailPage(
                                      post: item,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 32),

          /// RIGHT SIDEBAR - fixed (not scrolling with left)
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(32),
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 5 BERITA TERBARU
                  PoppinText(
                    text: "Berita Terbaru",
                    styles: StyleText(
                      size: 18,
                      weight: AppWeights.semiBold,
                      color: AppColors.darkGray,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: BlocBuilder<PostBloc, PostState>(
                      builder: (context, state) {
                        if (state is PostsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is PostsLoaded) {
                          final latestPosts = state.allPosts.take(5).toList();
                          return ListView.builder(
                            itemCount: latestPosts.length,
                            itemBuilder: (context, index) {
                              final item = latestPosts[index];
                              return latestStoryItem(
                                item.title,
                                item.author!.username,
                                item.image,
                                () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DesktopActivityDetailPage(post: item),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// CHIP
  Widget categoryChip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    );
  }

  /// LATEST STORY ITEM
  Widget latestStoryItem(
    String title,
    String author,
    String? imageUrl,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl ?? "https://picsum.photos/80/80",
                height: 48,
                width: 48,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "by $author",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
