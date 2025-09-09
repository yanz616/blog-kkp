import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/data/models/response/response_model.dart';
import 'package:fe/data/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_event.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostsInitial()) {
    //semua postingan
    on<FetchPosts>((event, emit) async {
      emit(const PostsLoading());
      try {
        final response = await postRepository.fetchPosts();
        if (response is SuccessResponse<List<PostModel>>) {
          emit(
            state is PostsLoaded
                ? (state as PostsLoaded).copyWith(allPosts: response.data)
                : PostsLoaded(allPosts: response.data),
          );
        } else if (response is ErrorResponse) {
          emit(PostsFailure(response.message));
        }
      } catch (_) {
        emit(
          const PostsFailure("Terjadi kesalahan periksa koneksi internet anda"),
        );
      }
    });

    on<FetchMyPosts>((event, emit) async {
      emit(const PostsLoading());
      try {
        final response = await postRepository.fetchMyPosts();
        if (response is SuccessResponse<List<PostModel>>) {
          emit(
            state is PostsLoaded
                ? (state as PostsLoaded).copyWith(myPosts: response.data)
                : PostsLoaded(myPosts: response.data),
          );
        } else if (response is ErrorResponse) {
          emit(PostsFailure(response.message));
        }
      } catch (_) {
        emit(
          const PostsFailure("Terjadi kesalahan periksa koneksi internet anda"),
        );
      }
    });

    //
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
}
