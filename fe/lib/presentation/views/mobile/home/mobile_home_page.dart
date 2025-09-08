import 'package:fe/presentation/blocs/posts/post_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_event.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';
// import 'package:fe/presentation/views/mobile/home/activity_detail_page.dart';
import 'package:fe/presentation/widgets/activities_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PostBloc>().add(FetchPosts());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kegiatan Magang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0D47A1),
        elevation: 0,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is PostsLoaded) {
            final post = state.posts;
            return ListView.builder(
              itemCount: post.length,
              itemBuilder: (context, i) {
                final item = post[i];
                return ActivitiesCard(
                  title: item.title,
                  author: item.author.username,
                  date: item.createdAt!,
                  imageUrl: item.image,
                  avatar: item.author.avatar,
                  onTap: () {},
                );
              },
            );
          }
          if (state is PostsFailure) {
            return Text(state.message);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
