import 'package:fe/data/models/posts/post_model.dart';

abstract class PostState {}

class PostsInitial extends PostState {}

class PostsLoading extends PostState {}

class PostsSuccess extends PostState {
  final String message;
  final PostModel postModel;
  final bool success = true;

  PostsSuccess(this.message, this.postModel);
}

class PostsFailure extends PostState {
  final String message;
  final bool success = false;

  PostsFailure(this.message);
}
