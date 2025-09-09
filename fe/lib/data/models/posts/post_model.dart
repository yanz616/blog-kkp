class AuthorModel {
  final int id;
  final String username;
  final String? avatar;

  const AuthorModel({required this.id, required this.username, this.avatar});

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'],
      username: json['username'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'avatar': avatar};
  }
}

class PostModel {
  final int id;
  final String title;
  final String content;
  final String? image;
  final AuthorModel author;
  final String? createdAt;
  final String? updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    required this.author,
    this.createdAt,
    this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id:
          json['id'] is int
              ? json['id']
              : int.parse(json['id'].toString()), // kalau gagal -> lempar error
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      image: json['image']?.toString().trim(),
      author: AuthorModel.fromJson(json['author']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'author': author.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
