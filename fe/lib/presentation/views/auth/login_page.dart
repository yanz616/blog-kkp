// import 'package:fe/data/models/request/auth_request.dart';
// import 'package:fe/presentation/blocs/auth/Auth_event.dart';
// import 'package:fe/presentation/blocs/auth/auth_bloc.dart';
// import 'package:fe/presentation/blocs/auth/auth_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   // Simpan error untuk masing-masing field
//   String? _emailError;
//   String? _passwordError;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Login")),
//       body: BlocConsumer<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is AuthSuccess) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text("✅ ${state.message}")));
//           } else if (state is AuthFailure) {
//             // Jika ada field error
//             setState(() {
//               _emailError = state.errors['email']?.first;
//               _passwordError = state.errors['password']?.first;
//             });

//             // Jika error umum
//             if (state.message.isNotEmpty) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text("❌ ${state.message}"),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//             }
//           }
//         },
//         builder: (context, state) {
//           if (state is AuthLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: "Email",
//                     errorText: _emailError,
//                   ),
//                   onChanged: (_) {
//                     if (_emailError != null) {
//                       setState(() => _emailError = null);
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: "Password",
//                     errorText: _passwordError,
//                   ),
//                   onChanged: (_) {
//                     if (_passwordError != null) {
//                       setState(() => _passwordError = null);
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     final email = _emailController.text.trim();
//                     final password = _passwordController.text.trim();

//                     // reset error sebelum request
//                     setState(() {
//                       _emailError = null;
//                       _passwordError = null;
//                     });

//                     context.read<AuthBloc>().add(
//                       LoginEvent(
//                         LoginRequest(email: email, password: password),
//                       ),
//                     );
//                   },
//                   child: const Text("Login"),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:fe/data/models/request/auth_request.dart';
import 'package:fe/presentation/blocs/auth/auth_bloc.dart';
import 'package:fe/presentation/blocs/auth/Auth_event.dart';
import 'package:fe/presentation/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Simpan error untuk masing-masing field
  String? _emailError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("✅ ${state.message}")));
          } else if (state is AuthFailure) {
            setState(() {
              _emailError = state.errors['email']?.first;
              _passwordError = state.errors['password']?.first;
            });

            if (state.message.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("❌ ${state.message}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    errorText: _emailError,
                  ),
                  onChanged: (_) {
                    if (_emailError != null) {
                      setState(() => _emailError = null);
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    errorText: _passwordError,
                  ),
                  onChanged: (_) {
                    if (_passwordError != null) {
                      setState(() => _passwordError = null);
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();

                    context.read<AuthBloc>().add(
                      LoginEvent(
                        LoginRequest(email: email, password: password),
                      ),
                    );
                    // reset error sebelum request
                    setState(() {
                      _emailError = null;
                      _passwordError = null;
                    });
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
