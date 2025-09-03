import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/data/models/request/auth_request.dart';
import 'package:fe/main.dart';
import 'package:fe/presentation/blocs/auth/auth_bloc.dart';
import 'package:fe/presentation/blocs/auth/auth_event.dart';
import 'package:fe/presentation/blocs/auth/auth_state.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MobileRegisterPage extends StatefulWidget {
  const MobileRegisterPage({super.key});

  @override
  State<MobileRegisterPage> createState() => _MobileRegisterPageState();
}

class _MobileRegisterPageState extends State<MobileRegisterPage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmedController;

  // String? _usernameError;
  // String? _emailError;
  // String? _passwordError;

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

  // String isPasswordMatch(
  //   String password,
  //   String passwordConfirmed,
  //   String passwordMessage,
  // ) {
  //   password = _passwordController.text.trim();
  //   passwordConfirmed = _passwordConfirmedController.text.trim();

  //   if (password != passwordConfirmed) {
  //     return passwordMessage = "Password Does not match";
  //   } else {
  //     return "";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Logo Aplikasi
                  const Icon(
                    Icons.person_add, // Ikon untuk register
                    size: 100,
                    color: AppColors.oldBlue, // Biru Tua
                  ),
                  const Gap(16),
                  // Judul & Sub-judul
                  PoppinText(
                    text: 'Daftar Akun Baru',
                    styles: StyleText(
                      size: 28,
                      weight: AppWeights.bold,
                      color: AppColors.lightBlue,
                    ),
                  ),
                  const Gap(8.0),
                  PoppinText(
                    text:
                        'Bargabunglah dengan Blog Magang IKP DISKOMINFOTIK NTP ',
                    styles: StyleText(size: 16, color: AppColors.mediumGray),
                  ),
                  const Gap(48.0),
                  // Formulir Nama Lengkap
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: const Icon(
                        Icons.person,
                        color: AppColors.oldBlue,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      // errorText: _usernameError,
                      filled: true,
                      fillColor: AppColors.white,
                    ),
                  ),
                  const Gap(16.0),
                  // Formulir Email
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(
                        Icons.email,
                        color: AppColors.oldBlue,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      // errorText: _emailError,
                      filled: true,
                      fillColor: AppColors.white,
                    ),
                  ),
                  const Gap(16.0),
                  // Formulir Password
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
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      // errorText: _passwordError,
                      filled: true,
                      fillColor: AppColors.white,
                    ),
                  ),
                  Gap(16),
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
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      // errorText: _passwordError,
                      filled: true,
                      fillColor: AppColors.white,
                    ),
                  ),
                  const Gap(24.0),
                  // Tombol Daftar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final username = _usernameController.text.trim();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        final passwordConfirmed = _passwordConfirmedController
                            .text
                            .trim();

                        // setState(() {
                        //   _usernameError = null;
                        //   _emailError = null;
                        //   _passwordError = null;
                        // });

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
                        backgroundColor: AppColors.lightBlue, // Biru Cerah
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: PoppinText(
                        text: 'Daftar',
                        styles: StyleText(size: 18, color: AppColors.white),
                      ),
                    ),
                  ),
                  const Gap(16.0),
                  // Tautan ke Halaman Login (dengan animasi)
                  TextButton(
                    onPressed: () {
                      // Navigasi kembali ke halaman login dengan transisi kustom
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              const MyApp(), // Pastikan nama kelas login page benar
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                const begin = Offset(
                                  1.0,
                                  0.0,
                                ); // Geser dari kanan
                                const end = Offset.zero;
                                const curve = Curves.ease;

                                var tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                        ),
                      );
                    },
                    child: PoppinText(
                      text: 'Sudah punya akun? Masuk di sini',
                      styles: StyleText(color: Color(0xFF0D47A1)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthSuccess) {
            // LocalStorage.setString(state.user.)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: PoppinText(
                  text: state.message,
                  styles: StyleText(
                    size: 18,
                    weight: AppWeights.semiBold,
                    color: AppColors.ufoGreen,
                  ),
                ),
                backgroundColor: AppColors.mintCream,
              ),
            );
          } else if (state is AuthFailure) {
            if (_passwordController.text.trim() !=
                _passwordConfirmedController.text.trim()) {
              // return message("Password Does Not Match");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Password Does Not Match")),
              );
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          }
        },
      ),
    );
  }
}
