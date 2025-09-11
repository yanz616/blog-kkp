import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/data/models/request/auth_request.dart';
import 'package:fe/main.dart';
import 'package:fe/presentation/blocs/auth/auth_bloc.dart';
import 'package:fe/presentation/blocs/auth/auth_event.dart';
import 'package:fe/presentation/blocs/auth/auth_state.dart';
import 'package:fe/presentation/views/desktop/auth/login_page.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DesktopRegisterPage extends StatefulWidget {
  const DesktopRegisterPage({super.key});

  @override
  State<DesktopRegisterPage> createState() => _DesktopRegisterPageState();
}

class _DesktopRegisterPageState extends State<DesktopRegisterPage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmedController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmedController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmedController.dispose();
    super.dispose();
  }

  void _showSnackBar(BuildContext context, String message, bool success) {
    final overlay = Overlay.of(context);
    final animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: Duration(milliseconds: 300),
    );
    final animation = Tween<Offset>(
      begin: Offset(0, -1), // mulai di luar layar atas
      end: Offset(0, 0), // turun ke posisi
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    final entry = OverlayEntry(
      builder:
          (context) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SlideTransition(
                  position: animation,
                  child: Material(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 66,
                        vertical: 12,
                      ),
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
                          color:
                              success ? AppColors.ufoGreen : AppColors.crimson,
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
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Container(
              width: 900, // Lebar kontainer untuk desktop/tablet
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  // Kolom Kiri: Formulir Register
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          PoppinText(
                            text: 'Daftar Akun Baru',
                            styles: StyleText(
                              size: 28,
                              weight: AppWeights.bold,
                              color: AppColors.darkGray,
                            ),
                          ),
                          const Gap(8.0),
                          PoppinText(
                            text: 'Silakan isi detail akun Anda',
                            styles: StyleText(
                              size: 16,
                              color: Color(0xFF757575),
                            ),
                          ),
                          const Gap(48.0),
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Nama Lengkap',
                              prefixIcon: const Icon(
                                Icons.person,
                                color: AppColors.oldBlue,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const Gap(16.0),
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
                          const Gap(16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
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
                          const Gap(16),
                          TextFormField(
                            controller: _passwordConfirmedController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Konfirmasi Sandi',
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: AppColors.oldBlue,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const Gap(24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final username =
                                    _usernameController.text.trim();
                                final email = _emailController.text.trim();
                                final password =
                                    _passwordController.text.trim();
                                final passwordConfirmed =
                                    _passwordConfirmedController.text.trim();

                                context.read<AuthBloc>().add(
                                  RegisterEvent(
                                    RegisterRequest(
                                      username: username,
                                      email: email,
                                      password: password,
                                      passConfirmation: passwordConfirmed,
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
                              child: PoppinText(
                                text: 'Daftar',
                                styles: StyleText(
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Gap(16.0),
                          Row(
                            children: [
                              PoppinText(
                                text: 'Sudah Punya Akun?',
                                styles: StyleText(color: AppColors.oldBlue),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigasi kembali ke halaman login
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) =>
                                              const MyApp(), // Pastikan nama kelas login page desktop benar
                                      transitionsBuilder: (
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
                                  text: 'Masuk di sini',
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
                  // Kolom Kanan: Ilustrasi
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.oldBlue, // Biru Tua
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.group_add, // Ikon lain yang relevan
                                size: 80,
                                color: AppColors.white,
                              ),
                              Gap(16),
                              PoppinText(
                                text: 'Selamat Datang Calon Magang',
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
                                    'Daftarkan diri Anda untuk mulai mendokumentasikan kegiatan.',
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
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthSuccess) {
            _showSnackBar(context, state.message, state.success);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DesktopLoginPage()),
            );
          } else if (state is AuthFailure) {
            if (_passwordController.text.trim() !=
                _passwordConfirmedController.text.trim()) {
              _showSnackBar(context, 'Password Does not Match', state.success);
            } else {
              _showSnackBar(context, state.message, state.success);
            }
          }
        },
      ),
    );
  }
}
