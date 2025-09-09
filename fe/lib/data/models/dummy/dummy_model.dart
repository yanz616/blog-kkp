import 'package:flutter_bloc/flutter_bloc.dart';

/// =======================
/// MODEL
/// =======================
class User {
  final int id;
  final String username;
  final String email;
  final String avatar;
  final String token;
  final String password;
  final String createdAt;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
    required this.token,
    required this.password,
    required this.createdAt,
  });
}

class AuthorModel {
  final int id;
  final String username;
  final String? avatar;

  const AuthorModel({required this.id, required this.username, this.avatar});
}

class PostModel {
  final int id;
  final String title;
  final String content;
  final String? image;
  final AuthorModel author;
  final String? createdAt;
  final String? updatedAt;

  const PostModel({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    required this.author,
    this.createdAt,
    this.updatedAt,
  });
}

/// =======================
/// DUMMY DATA
/// =======================
final dummyUsers = [
  User(
    id: 1,
    username: "John Doe",
    email: "john.doe@example.com",
    avatar: "https://api.dicebear.com/7.x/avataaars/svg?seed=John",
    token: "token_1",
    password: "password1",
    createdAt: DateTime.now().toIso8601String(),
  ),
  User(
    id: 2,
    username: "Jane Smith",
    email: "jane.smith@example.com",
    avatar: "https://api.dicebear.com/7.x/avataaars/svg?seed=Jane",
    token: "token_2",
    password: "password2",
    createdAt: DateTime.now().toIso8601String(),
  ),
];

final author1 = AuthorModel(
  id: 1,
  username: "john_doe",
  avatar: "https://i.pravatar.cc/150?img=3",
);

final author2 = AuthorModel(
  id: 2,
  username: "jane_smith",
  avatar: "https://i.pravatar.cc/150?img=5",
);

final dummyPosts = [
  PostModel(
    id: 101,
    title: "Belajar Flutter BLoC",
    content: "Hari ini saya belajar Flutter BLoC.",
    image: "https://picsum.photos/200/300",
    author: author1,
    createdAt: "2025-09-09T10:00:00Z",
    updatedAt: "2025-09-09T10:30:00Z",
  ),
  PostModel(
    id: 102,
    title: "Membuat API Laravel",
    content: "Laravel memudahkan kita bikin REST API.",
    image: null,
    author: author1,
    createdAt: "2025-09-08T09:00:00Z",
    updatedAt: "2025-09-08T09:30:00Z",
  ),
  PostModel(
    id: 103,
    title: "Tips Produktif Magang",
    content: "Selalu catat kegiatan harianmu.",
    image: "https://picsum.photos/200/301",
    author: author2,
    createdAt: "2025-09-07T14:00:00Z",
    updatedAt: "2025-09-07T15:00:00Z",
  ),
];

/// =======================
/// REPOSITORY (Dummy)
/// =======================
class AuthRepositoryDummy {
  User? _currentUser;

  Future<User?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final user = dummyUsers.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      _currentUser = user;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  User? get currentUser => _currentUser;
}

class PostRepositoryDummy {
  Future<List<PostModel>> fetchPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return dummyPosts;
  }
}

/// =======================
/// AUTH BLOC
/// =======================
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

class LogoutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  Authenticated(this.user);
}

class Unauthenticated extends AuthState {
  final String? message;
  Unauthenticated({this.message});
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryDummy repo;
  AuthBloc(this.repo) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final user = await repo.login(event.email, event.password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated(message: "Email atau password salah"));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await repo.logout();
      emit(Unauthenticated());
    });

    on<CheckAuthStatus>((event, emit) async {
      final user = repo.currentUser;
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });
  }
}

/// =======================
/// POST BLOC
/// =======================
abstract class PostEvent {}

class FetchPosts extends PostEvent {}

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> posts;
  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepositoryDummy repo;
  PostBloc(this.repo) : super(PostInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await repo.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError("Gagal memuat postingan"));
      }
    });
  }
}
