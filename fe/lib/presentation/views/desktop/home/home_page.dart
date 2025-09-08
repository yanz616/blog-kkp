import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/presentation/blocs/posts/post_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_event.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';
import 'package:fe/presentation/views/desktop/home/activity_detail_page.dart';
import 'package:fe/presentation/widgets/activities_card.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesktopHomePage extends StatelessWidget {
  const DesktopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PostBloc>().add(FetchPosts());
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
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostsLoaded) {
                  final List<PostModel> posts = state.posts;
                  if (state.posts.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Postingan masi Kosong")),
                    );
                    return SizedBox.shrink();
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 18.0,
                        ),
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return ActivitiesCard(
                        title: post.title,
                        author: post.author.username,
                        date: post.createdAt.toString(),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DesktopActivityDetailPage(post: post),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is PostsFailure) {
                  return Center(child: Text(state.message));
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
