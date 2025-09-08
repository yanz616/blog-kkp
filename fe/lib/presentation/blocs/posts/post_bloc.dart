import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/data/models/response/response_model.dart';
import 'package:fe/data/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_event.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostsInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostsLoading());
      try {
        final response = await postRepository.fetchPosts();
        if (response is SuccessResponse<List<PostModel>>) {
          emit(PostsLoaded(response.data, response.message));
        } else if (response is ErrorResponse) {
          emit(PostsFailure(response.message));
        }
      } catch (e) {
        emit(PostsFailure("Terjadi kesalahan periksa koneksi internet anda"));
      }
    });
    on<FetchPostById>((event, emit) async {
      emit(PostsLoading());
      try {
        final response = await postRepository.fetchPost(event.id);
        if (response is SuccessResponse<PostModel>) {
          emit(PostLoaded(response.data, response.message));
        } else if (response is ErrorResponse) {
          emit(PostsFailure(response.message));
        }
      } catch (e) {
        emit(PostsFailure("Terjadi kesalahan periksa koneksi internet anda"));
      }
    });
    on<CreatePost>((event, emit) async {
      emit(const PostsLoading());
      try {
        final response = await postRepository.createPost(event.postRequest);
        if (response is SuccessResponse<PostModel>) {
          emit(PostsSuccess(response.message));
        } else if (response is ErrorResponse) {
          emit(PostsFailure(response.message));
        }
      } catch (e) {
        emit(const PostsFailure("Terjadi kesalahan saat membuat post."));
      }
    });
  }
  // final FakePostRepository fakePostRepository;

  // PostBloc(this.fakePostRepository) : super(const PostsInitial()) {
  //   //  Get all posts
  //   on<FetchPosts>((event, emit) async {
  //     emit(const PostsLoading());
  //     try {
  //       final response = await fakePostRepository.getPosts();
  //       if (response is SuccessResponse<List<PostModel>>) {
  //         emit(PostsLoaded(response.data, response.message));
  //       } else if (response is ErrorResponse) {
  //         emit(PostsFailure(response.message));
  //       }
  //     } catch (e) {
  //       emit(const PostsFailure("Terjadi kesalahan saat mengambil postingan."));
  //     }
  //   });

  //   //  Get post by id
  //   on<FetchPostById>((event, emit) async {
  //     emit(const PostsLoading());
  //     try {
  //       final response = await fakePostRepository.getPostById(event.id);
  //       if (response is SuccessResponse<PostModel>) {
  //         emit(PostLoaded(response.data, response.message));
  //       } else if (response is ErrorResponse) {
  //         emit(PostsFailure(response.message));
  //       }
  //     } catch (e) {
  //       emit(
  //         const PostsFailure("Terjadi kesalahan saat mengambil detail post."),
  //       );
  //     }
  //   });

  //  Create post
  // on<CreatePost>((event, emit) async {
  //   emit(const PostsLoading());
  //   try {
  //     final response = await fakePostRepository.createPost(event.postRequest);
  //     if (response is SuccessResponse<PostModel>) {
  //       emit(PostsSuccess(response.message));
  //     } else if (response is ErrorResponse) {
  //       emit(PostsFailure(response.message));
  //     }
  //   } catch (e) {
  //     emit(const PostsFailure("Terjadi kesalahan saat membuat post."));
  //   }
  // });

  //   //  Delete post
  //   on<DeletePost>((event, emit) async {
  //     emit(const PostsLoading());
  //     try {
  //       final response = await fakePostRepository.deletePost(event.id);
  //       if (response is SuccessResponse) {
  //         emit(PostsSuccess(response.message));
  //       } else if (response is ErrorResponse) {
  //         emit(PostsFailure(response.message));
  //       }
  //     } catch (e) {
  //       emit(const PostsFailure("Terjadi kesalahan saat menghapus post."));
  //     }
  //   });

  //   //  Get my posts
  //   on<FetchMyPost>((event, emit) async {
  //     emit(const PostsLoading());
  //     try {
  //       final response = await fakePostRepository.getMyPosts(event.id);
  //       if (response is SuccessResponse<List<PostModel>>) {
  //         emit(PostsLoaded(response.data, response.message));
  //       } else if (response is ErrorResponse) {
  //         emit(PostsFailure(response.message));
  //       }
  //     } catch (e) {
  //       emit(
  //         const PostsFailure(
  //           "Terjadi kesalahan saat mengambil postingan saya.",
  //         ),
  //       );
  //     }
  //   });
  // }
}
