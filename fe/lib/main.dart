import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/data/repositories/auth_repository.dart';
import 'package:fe/presentation/blocs/auth/auth_bloc.dart';
import 'package:fe/presentation/layouts/rensponsive_layout.dart';
import 'package:fe/presentation/views/desktop/navigation/desktop_navigation.dart';
import 'package:fe/presentation/views/mobile/navigation/mobile_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AuthBloc(AuthRepository()))],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.youngGray),
        home: ResponsiveLayout(
          mobileLayout: MobileMainScaffold(),
          desktopLayout: DesktopMainScaffold(),
        ),
      ),
    );
  }
}
