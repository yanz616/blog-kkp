import 'dart:io';

class PostRequest {
  final String title;
  final String content;
  final File? image;

  PostRequest({required this.title, required this.content, this.image});

  /// Untuk request tanpa file (misalnya form-urlencoded / JSON)
  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content};
  }

  /// Untuk request multipart (dengan file)
  Map<String, dynamic> toMultipart() {
    return {
      'title': title,
      'content': content,
      if (image != null) 'image': image,
    };
  }
}
