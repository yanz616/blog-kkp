import 'package:fe/data/models/posts/post_model.dart';

abstract class PostState {
  const PostState();
}

class PostsInitial extends PostState {
  const PostsInitial();
}

class PostsLoading extends PostState {
  const PostsLoading();
}

/// state sukses dengan dua list
// class PostsLoaded extends PostState {
//   final List<PostModel> allPosts;
//   final List<PostModel> myPosts;

//   const PostsLoaded({this.allPosts = const [], this.myPosts = const []});

//   PostsLoaded copyWith({List<PostModel>? allPosts, List<PostModel>? myPosts}) {
//     return PostsLoaded(
//       allPosts: allPosts ?? this.allPosts,
//       myPosts: myPosts ?? this.myPosts,
//     );
//   }
// }
class PostsLoaded extends PostState {
  final List<PostModel> allPosts;
  final List<PostModel> myPosts;

  const PostsLoaded({this.allPosts = const [], this.myPosts = const []});

  PostsLoaded copyWith({List<PostModel>? allPosts, List<PostModel>? myPosts}) {
    return PostsLoaded(
      allPosts: allPosts ?? this.allPosts,
      myPosts: myPosts ?? this.myPosts,
    );
  }
}

class PostsSuccess extends PostState {
  final String message;
  final PostModel data;
  const PostsSuccess(this.message, this.data);
}

class PostDeleteSuccess extends PostState {
  final String message;

  const PostDeleteSuccess(this.message);
}

class PostsFailure extends PostState {
  final String message;
  const PostsFailure(this.message);
}
