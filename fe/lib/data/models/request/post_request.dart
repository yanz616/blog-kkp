import 'package:image_picker/image_picker.dart';

class PostRequest {
  final String title;
  final String content;
  final XFile? image;

  PostRequest({required this.title, required this.content, this.image});

  /// Untuk request tanpa file (misalnya form-urlencoded / JSON)
  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content};
  }
}
