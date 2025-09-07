import 'package:fe/data/models/request/post_request.dart';

abstract class PostEvent {}

class CreatePost extends PostEvent {
  final PostRequest postRequest;

  CreatePost(this.postRequest);
}
