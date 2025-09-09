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
    return Column(
      children: [
        AppBar(
          title: PoppinText(
            text: 'Kegiatan Magang',
            styles: StyleText(
              weight: AppWeights.bold,
              color: AppColors.darkGray,
            ),
          ),
          backgroundColor: AppColors.lightBlue,
          elevation: 0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostsLoaded) {
                  final posts = state.allPosts;
                  if (posts.isEmpty) {
                    return const Center(child: Text("Postingan masih kosong"));
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.9,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 18.0,
                        ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final item = posts[index];
                      return ActivitiesCard(
                        title: item.title,
                        author: item.author.username,
                        date: item.createdAt!,
                        avatar: item.author.avatar,
                        imageUrl: item.image,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      DesktopActivityDetailPage(post: item),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is PostsFailure) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
