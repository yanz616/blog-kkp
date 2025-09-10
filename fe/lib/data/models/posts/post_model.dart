// class AuthorModel {
//   final int id;
//   final String username;
//   final String? email;
//   final String? avatar;

//   const AuthorModel({
//     required this.id,
//     required this.username,
//     this.avatar,
//     this.email,
//   });

//   factory AuthorModel.fromJson(Map<String, dynamic> json) {
//     return AuthorModel(
//       id: json['id'],
//       username: json['username'],
//       email: json['email'],
//       avatar: json['avatar'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {'id': id, 'username': username, 'email': email, 'avatar': avatar};
//   }
// }

// class PostModel {
//   final int id;
//   final String title;
//   final String content;
//   final String? image;
//   final AuthorModel author;
//   final String? createdAt;
//   final String? updatedAt;

//   PostModel({
//     required this.id,
//     required this.title,
//     required this.content,
//     this.image,
//     required this.author,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory PostModel.fromJson(Map<String, dynamic> json) {
//     return PostModel(
//       id: json['id'] is int
//           ? json['id']
//           : int.parse(json['id'].toString()), // kalau gagal -> lempar error
//       title: json['title'] ?? '',
//       content: json['content'] ?? '',
//       image: json['image'],
//       author: AuthorModel.fromJson(json['author']),
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'content': content,
//       'image': image,
//       'author': author.toJson(),
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//     };
//   }
// }
class AuthorModel {
  final int id;
  final String username;
  final String? email;
  final String? avatar;

  const AuthorModel({
    required this.id,
    required this.username,
    this.email,
    this.avatar,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
    };
  }
}

class PostModel {
  final int id;
  final String title;
  final String content;
  final String? image;
  final AuthorModel? author;
  final String? createdAt;
  final String? updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    this.author,
    this.createdAt,
    this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      image: json['image'],
      author: json['author'] != null
          ? AuthorModel.fromJson(json['author'])
          : null,
      createdAt: json['createdAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      if (image != null) 'image': image,
      if (author != null) 'author': author!.toJson(),
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
    };
  }
}
