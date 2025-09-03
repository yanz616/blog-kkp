import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/data/models/request/auth_request.dart';
import 'package:fe/presentation/blocs/auth/auth_bloc.dart';
import 'package:fe/presentation/blocs/auth/auth_event.dart';
import 'package:fe/presentation/blocs/auth/auth_state.dart';
import 'package:fe/presentation/views/mobile/auth/register_page.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MobileLoginPage extends StatefulWidget {
  const MobileLoginPage({super.key});

  @override
  State<MobileLoginPage> createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passController;

  // String? _emailError;
  // String? _passError;

  @override
  void initState() {
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

  void _showSnackBar(
    BuildContext context,
    String message, {
    bool error = true,
  }) {
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
                    color: error ? AppColors.linen : AppColors.mintCream,
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
                      color: error ? AppColors.crimson : AppColors.ufoGreen,
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Logo Aplikasi
                  const Icon(
                    Icons.account_circle,
                    size: 100,
                    color: AppColors.oldBlue, // Biru Tua
                  ),
                  const Gap(16.0),
                  // Judul & Sub-judul
                  PoppinText(
                    text: 'Masuk ke Akun Anda',
                    styles: StyleText(
                      size: 28,
                      weight: AppWeights.bold,
                      color: AppColors.oldBlue,
                    ),
                  ),
                  const Gap(8.0),
                  PoppinText(
                    text: 'Blog Magang IKP DISKOMINFOTIK NTB',
                    styles: StyleText(
                      size: 16,
                      weight: AppWeights.regular,
                      color: AppColors.mediumGray,
                    ),
                  ),
                  const Gap(48.0),
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
                    controller: _passController,
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
                      // errorText: _passError,
                      filled: true,
                      fillColor: AppColors.white,
                    ),
                  ),
                  const Gap(24.0),
                  // Tombol Login
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final email = _emailController.text.trim();
                        final password = _passController.text.trim();

                        // setState(() {
                        //   _emailError = null;
                        //   _passError = null;
                        // });
                        context.read<AuthBloc>().add(
                          LoginEvent(
                            LoginRequest(email: email, password: password),
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
                        text: "Masuk",
                        styles: StyleText(
                          size: 18,
                          weight: AppWeights.regular,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  const Gap(16.0),
                  // Tautan Register
                  Row(
                    children: [
                      PoppinText(
                        text: 'Belum Punya Akun?',
                        styles: StyleText(
                          size: 14,
                          weight: AppWeights.regular,
                          color: AppColors.oldBlue,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const MobileRegisterPage(), // Pastikan nama kelas login page benar
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
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
                          text: 'Sign Up',
                          styles: StyleText(
                            size: 14,
                            weight: AppWeights.regular,
                            color: AppColors.oldBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthSuccess) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: PoppinText(
            //       text: state.message,
            //       styles: StyleText(
            //         size: 18,
            //         weight: AppWeights.semiBold,
            //         color: AppColors.ufoGreen,
            //       ),
            //     ),
            //     backgroundColor: AppColors.mintCream,
            //   ),
            // );
            _showSnackBar(context, state.message);
          } else if (state is AuthFailure) {
            _showSnackBar(context, state.message);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: PoppinText(
            //       text: state.message,
            //       styles: StyleText(
            //         size: 18,
            //         weight: AppWeights.semiBold,
            //         color: AppColors.crimson,
            //       ),
            //     ),
            //     backgroundColor: AppColors.mutedRed,
            //   ),
            // );
          }
        },
      ),
    );
  }
}
