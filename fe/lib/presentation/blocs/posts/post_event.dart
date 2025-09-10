import 'package:fe/data/models/request/post_request.dart';

abstract class PostEvent {
  const PostEvent();
}

class FetchPosts extends PostEvent {
  const FetchPosts();
}

class FetchMyPosts extends PostEvent {
  const FetchMyPosts();
}

class CreatePost extends PostEvent {
  final PostRequest postRequest;

  const CreatePost(this.postRequest);
}

class UpdatePost extends PostEvent {
  final PostRequest postRequest;
  final int id;

  const UpdatePost(this.postRequest, {required this.id});
}

class DeletePost extends PostEvent {
  final int id;

  const DeletePost(this.id);
}
