import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// class PostRequest {
//   final String title;
//   final String content;
//   final XFile? image;

//   PostRequest({required this.title, required this.content, this.image});

//   /// Untuk request tanpa file (misalnya form-urlencoded / JSON)
//   Map<String, dynamic> toMap() {
//     return {'title': title, 'content': content};
//   }
// }

class PostRequest {
  final String title;
  final String content;
  final XFile? image;

  PostRequest({required this.title, required this.content, this.image});

  /// Untuk request JSON / form-urlencoded (tanpa file)
  Map<String, String> toMap() {
    return {'title': title, 'content': content};
  }

  /// Untuk multipart (support Web & Mobile)
  Future<void> applyToMultipart(http.MultipartRequest request) async {
    request.fields['title'] = title;
    request.fields['content'] = content;

    if (image != null) {
      final bytes = await image!.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: image!.name,
      );
      request.files.add(multipartFile);
    }
  }
}
