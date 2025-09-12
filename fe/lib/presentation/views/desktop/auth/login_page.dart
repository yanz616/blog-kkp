import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/core/utils/local_storage.dart';
import 'package:fe/data/models/request/auth_request.dart';
import 'package:fe/presentation/blocs/auth/auth_bloc.dart';
import 'package:fe/presentation/blocs/auth/auth_event.dart';
import 'package:fe/presentation/blocs/auth/auth_state.dart';
import 'package:fe/presentation/views/admin/navigation/navigation.dart';
import 'package:fe/presentation/views/desktop/auth/register_page.dart';
import 'package:fe/presentation/views/desktop/navigation/desktop_navigation.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DesktopLoginPage extends StatefulWidget {
  const DesktopLoginPage({super.key});

  @override
  State<DesktopLoginPage> createState() => _DesktopLoginPageState();
}

class _DesktopLoginPageState extends State<DesktopLoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passController;
  bool _isObscure = true;

  Future<void> isAuthenticated() async {
    final token = await LocalStorage.getString();
    final isAdmin = await LocalStorage.getIsAdmin();
    if (!mounted) return;
    if (token != null && token.isNotEmpty) {
      if (isAdmin == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AdminMainScaffold()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DesktopMainScaffold()),
        );
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isAuthenticated();
    });
    _emailController = TextEditingController();
    _passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _showSnackBar(BuildContext context, String message, bool success) {
    final overlay = Overlay.of(context);
    final animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: Duration(milliseconds: 300),
    );
    final animation =
        Tween<Offset>(
          begin: Offset(0, -1), // mulai di luar layar atas
          end: Offset(0, 0), // turun ke posisi
        ).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        );

    final entry = OverlayEntry(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SlideTransition(
              position: animation,
              child: Material(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 66, vertical: 12),
                  decoration: BoxDecoration(
                    color: success ? AppColors.mintCream : AppColors.linen,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppColors.lightSlateGray,
                      width: 1,
                    ),
                  ),
                  child: PoppinText(
                    text: message,
                    styles: StyleText(
                      size: 12,
                      weight: AppWeights.bold,
                      color: success ? AppColors.ufoGreen : AppColors.crimson,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    overlay.insert(entry);
    animationController.forward();
    Future.delayed(Duration(seconds: 2), () {
      animationController.reverse().then((_) => entry.remove());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          // if (state is AuthLoading) {
          //   return Center(child: CircularProgressIndicator());
          // }
          return Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              width: 900, // Lebar kontainer untuk desktop/tablet
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(2, 5),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  // Kolom Kiri: Ilustrasi
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.oldBlue, // Biru Tua
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          bottomLeft: Radius.circular(16.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              // padding: EdgeInsets.all(20),
                              child: Image.asset("assets/logo/ikpLogo.png"),
                            ),

                            // Icon(
                            //   Icons.dashboard,
                            //   size: 80,
                            //   color: AppColors.white,
                            // ),
                            Gap(16),
                            PoppinText(
                              text: 'Selamat Datang di Portal Magang',
                              textAlign: TextAlign.center,
                              styles: StyleText(
                                size: 24,
                                weight: AppWeights.bold,
                                color: AppColors.white,
                              ),
                            ),
                            Gap(8),
                            PoppinText(
                              text:
                                  'Kelola dokumentasi kegiatan Anda dengan mudah.',
                              textAlign: TextAlign.center,
                              styles: StyleText(
                                size: 16,
                                color: AppColors.transparentWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Kolom Kanan: Formulir Login
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          PoppinText(
                            text: 'Masuk Ke Akun',
                            styles: StyleText(
                              size: 28,
                              weight: AppWeights.bold,
                              color: AppColors.darkGray,
                            ),
                          ),
                          const Gap(8.0),
                          PoppinText(
                            text: 'Silahkan masukan detail akun anda',
                            styles: StyleText(
                              size: 16,
                              color: AppColors.mediumGray,
                            ),
                          ),
                          const Gap(48.0),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(
                                Icons.email,
                                color: AppColors.oldBlue,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const Gap(16.0),
                          TextFormField(
                            controller: _passController,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              labelText: 'Kata Sandi',
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: AppColors.oldBlue,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const Gap(24.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final email = _emailController.text.trim();
                                final password = _passController.text.trim();

                                context.read<AuthBloc>().add(
                                  LoginEvent(
                                    LoginRequest(
                                      email: email,
                                      password: password,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.lightBlue,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: state is AuthLoading
                                  ? const CircularProgressIndicator(
                                      color: AppColors.white,
                                    )
                                  : PoppinText(
                                      text: 'Masuk',
                                      styles: StyleText(
                                        size: 18,
                                        color: AppColors.white,
                                      ),
                                    ),
                            ),
                          ),
                          const Gap(16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PoppinText(
                                text: 'Belum punya akun?',
                                styles: StyleText(color: AppColors.oldBlue),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => const DesktopRegisterPage(),
                                      transitionsBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                            child,
                                          ) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                    ),
                                  );
                                },
                                child: PoppinText(
                                  text: 'Daftar di sini',
                                  styles: StyleText(
                                    weight: AppWeights.semiBold,
                                    color: AppColors.oldBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthSuccess) {
            _showSnackBar(context, state.message, state.success);

            if (state.user.isAdmin == true) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AdminMainScaffold()),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => DesktopMainScaffold()),
              );
            }
          } else if (state is AuthFailure) {
            _showSnackBar(context, state.message, state.success);
          }
        },
      ),
    );
  }
}
