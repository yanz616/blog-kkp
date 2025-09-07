import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/data/models/response/response_model.dart';
import 'package:fe/data/repositories/post_repository.dart';
import 'package:fe/presentation/blocs/posts/post_event.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(const PostsInitial()) {
    on<CreatePost>((event, emit) async {
      emit(const PostsLoading());

      try {
        final response = await postRepository.createPost(event.postRequest);

        if (response is SuccessResponse<PostModel>) {
          emit(PostsSuccess(response.message, response.data));
        } else if (response is ErrorResponse) {
          emit(PostsFailure(response.message));
        } else {
          emit(const PostsFailure("Terjadi kesalahan yang tidak diketahui"));
        }
      } catch (e) {
        emit(PostsFailure("Exception: ${e.toString()}"));
      }
    });
  }
}
