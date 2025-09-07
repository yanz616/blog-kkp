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

class PostsSuccess extends PostState {
  final String message;
  final PostModel post;

  const PostsSuccess(this.message, this.post);
}

class PostsFailure extends PostState {
  final String message;

  const PostsFailure(this.message);
}
