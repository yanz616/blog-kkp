import 'package:fe/data/models/posts/post_model.dart';

abstract class PostState {
  const PostState();
}

/// Awal / belum ada action
class PostsInitial extends PostState {
  const PostsInitial();
}

/// Loading saat proses berjalan
class PostsLoading extends PostState {
  const PostsLoading();
}

/// State ketika berhasil ambil banyak post
class PostsLoaded extends PostState {
  final List<PostModel> posts;
  final String message;
  const PostsLoaded(this.posts, this.message);
}

/// State ketika berhasil ambil 1 post
class PostLoaded extends PostState {
  final PostModel post;
  final String message;
  const PostLoaded(this.post, this.message);
}

/// State ketika operasi berhasil tanpa butuh data tambahan
class PostsSuccess extends PostState {
  final String message;
  const PostsSuccess(this.message);
}

/// State ketika gagal
class PostsFailure extends PostState {
  final String message;
  const PostsFailure(this.message);
}
