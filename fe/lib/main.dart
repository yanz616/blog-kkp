import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/data/repositories/admin/admin_repository.dart';
import 'package:fe/data/repositories/auth_repository.dart';
import 'package:fe/data/repositories/post_repository.dart';
import 'package:fe/presentation/blocs/admin/admin_bloc.dart';
import 'package:fe/presentation/blocs/auth/auth_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_bloc.dart';
import 'package:fe/presentation/layouts/rensponsive_layout.dart';
import 'package:fe/presentation/views/desktop/auth/login_page.dart';
import 'package:fe/presentation/views/mobile/navigation/mobile_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/date_symbol_data_local.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi locale Bahasa Indonesia
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
        BlocProvider(create: (_) => PostBloc(PostRepository())),
        BlocProvider(create: (_) => AdminBloc(AdminRepository())),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          // GlobalMaterialLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate
          FlutterQuillLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.youngGray),
        home: const ResponsiveLayout(
          mobileLayout: MobileMainScaffold(),
          desktopLayout: DesktopLoginPage(),
        ),
      ),
    );
  }
}
