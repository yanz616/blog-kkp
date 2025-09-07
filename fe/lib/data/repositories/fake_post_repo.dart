import 'package:fe/core/constants/variabel.dart';
import 'package:fe/data/models/dummy/dummy_model.dart';
import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/data/models/request/post_request.dart';
import 'package:fe/data/models/response/response_model.dart';

class FakePostRepository {
  final String baseUrl = Variabel.baseUrl;

  var message = "Get Postingan berhasil";
  var errorMessage = "Get Postingan Gagal";

  Future<dynamic> getPosts() async {
    try {
      return SuccessResponse<List<PostModel>>(
        success: true,
        statusCode: 200,
        message: message,
        data: dummyPosts,
      );
    } catch (e) {
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: errorMessage,
      );
    }
  }

  Future<dynamic> getPostById(int id) async {
    try {
      final post = dummyPosts.firstWhere(
        (p) => p.id == id,
        orElse: () => PostModel(
          id: -1,
          title: "",
          content: "",
          authorId: -1,
          image: "",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      if (post.id != -1) {
        return SuccessResponse<PostModel>(
          success: true,
          statusCode: 200,
          message: "Post ditemukan",
          data: post,
        );
      } else {
        return ErrorResponse(
          success: false,
          statusCode: 404,
          message: "Post tidak ditemukan",
        );
      }
    } catch (e) {
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: "Gagal mengambil data post",
      );
    }
  }

  Future<dynamic> getMyPosts(int userId) async {
    try {
      final myPosts = dummyPosts.where((p) => p.authorId == userId).toList();

      return SuccessResponse<List<PostModel>>(
        success: true,
        statusCode: 200,
        message: "Data postingan milik user $userId berhasil diambil",
        data: myPosts,
      );
    } catch (e) {
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: "Gagal mengambil data postingan user",
      );
    }
  }

  Future<dynamic> createPost(PostRequest request) async {
    try {
      final newPost = PostModel(
        id: dummyPosts.length + 1,
        title: request.title,
        content: request.content,
        authorId: dummyUsers.first.id, // contoh: user pertama
        image: request.image?.path ?? "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      dummyPosts.add(newPost);

      return SuccessResponse<PostModel>(
        success: true,
        statusCode: 201,
        message: "Postingan berhasil dibuat",
        data: newPost,
      );
    } catch (e) {
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: "Gagal membuat postingan",
      );
    }
  }

  Future<dynamic> deletePost(int id) async {
    try {
      final index = dummyPosts.indexWhere((p) => p.id == id);
      if (index == -1) {
        return ErrorResponse(
          success: false,
          statusCode: 404,
          message: "Postingan tidak ditemukan",
        );
      }

      final deleted = dummyPosts.removeAt(index);
      return SuccessResponse<PostModel>(
        success: true,
        statusCode: 200,
        message: "Postingan berhasil dihapus",
        data: deleted,
      );
    } catch (_) {
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: "Gagal menghapus postingan",
      );
    }
  }
}
