import 'package:fe/data/models/request/post_request.dart';

abstract class PostEvent {
  const PostEvent();
}

class FetchPosts extends PostEvent {
  const FetchPosts();
}

class FetchPostById extends PostEvent {
  final int id;

  const FetchPostById(this.id);
}

class CreatePost extends PostEvent {
  final PostRequest postRequest;

  const CreatePost(this.postRequest);
}

class DeletePost extends PostEvent {
  final int id;

  const DeletePost(this.id);
}

class FetchMyPost extends PostEvent {
  final int id;
  const FetchMyPost(this.id);
}
