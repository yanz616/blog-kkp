import 'dart:io';

class PostRequest {
  final String title;
  final String content;
  final File image;

  PostRequest({
    required this.title,
    required this.content,
    required this.image,
  });
}
