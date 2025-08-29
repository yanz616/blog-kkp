import 'package:fe/data/models/request/auth_request.dart';
import 'package:fe/presentation/blocs/auth/auth_bloc.dart';
import 'package:fe/presentation/blocs/auth/auth_event.dart';
import 'package:fe/presentation/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmedController;

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmedController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is AuthFailure) {
            setState(() {
              _nameError = state.errors['name']?.first;
              _emailError = state.errors['email']?.first;
              _passwordError = state.errors['password']?.first;
            });
            if (state.message.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message, style: TextStyle(fontSize: 16)),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    errorText: _nameError,
                  ),
                  onChanged: (_) {
                    if (_nameError != null) {
                      setState(() => _nameError = null);
                    }
                  },
                ),
                Gap(10),
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
                Gap(10),
                TextField(
                  controller: _passwordController,
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
                Gap(10),
                TextField(
                  controller: _passwordConfirmedController,
                  decoration: InputDecoration(
                    labelText: "Password Confirmation",
                    errorText: _passwordError,
                  ),
                  onChanged: (_) {
                    if (_passwordError != null) {
                      setState(() => _passwordError = null);
                    }
                  },
                ),
                Gap(20),
                ElevatedButton(
                  onPressed: () {
                    final name = _nameController.text.trim();
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    final passwordConfirmation = _passwordConfirmedController
                        .text
                        .trim();
                    setState(() {
                      _nameError = null;
                      _emailError = null;
                      _passwordError = null;
                    });

                    context.read<AuthBloc>().add(
                      RegisterEvent(
                        RegisterRequest(
                          name: name,
                          email: email,
                          password: password,
                          passConfirmation: passwordConfirmation,
                        ),
                      ),
                    );
                  },
                  child: Text("Register"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
