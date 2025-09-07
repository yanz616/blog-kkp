import 'package:fe/data/helpers/date_time_helper.dart';

class PostModel {
  final int id;
  final String title;
  final String content;
  final String? image;
  final int authorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    required this.authorId,
    this.createdAt,
    this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null) {
      throw ArgumentError('Missing required field: id');
    }
    if (json['author_id'] == null) {
      throw ArgumentError('Missing required field: author_id');
    }

    return PostModel(
      id: json['id'] is int
          ? json['id']
          : int.parse(json['id'].toString()), // kalau gagal -> lempar error
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      image: json['image']?.toString(),
      authorId: json['author_id'] is int
          ? json['author_id']
          : int.parse(json['author_id'].toString()),
      createdAt: DateTimeHelper.parseDate(json['created_at']),
      updatedAt: DateTimeHelper.parseDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'author_id': authorId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
