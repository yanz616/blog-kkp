import 'package:fe/data/helpers/date_time_helper.dart';

class PostModel {
  final int id;
  final String title;
  final String content;
  final String image;
  final int authorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.authorId,
    this.createdAt,
    this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      authorId: json['author_id'],
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
