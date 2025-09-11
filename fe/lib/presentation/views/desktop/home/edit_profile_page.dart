import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/data/models/request/auth_request.dart';
import 'package:fe/data/models/user/user.dart';
import 'package:fe/presentation/blocs/auth/auth_bloc.dart';
import 'package:fe/presentation/blocs/auth/auth_event.dart';
import 'package:fe/presentation/blocs/auth/auth_state.dart';
import 'package:fe/presentation/views/desktop/navigation/desktop_navigation.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final User? userData;
  const EditProfilePage({super.key, this.userData});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  XFile? _selectedAvatar;
  Uint8List? _avatarBytes;

  @override
  void initState() {
    _usernameController = TextEditingController(
      text: widget.userData!.username,
    );
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  // Future<void> _pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (pickedFile != null) {
  //     final bytes = await P
  //     setState(() {
  //       _selectedAvatar = pickedFile; // langsung aja
  //     });
  //   }
  // }
  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _selectedAvatar = picked;
        _avatarBytes = bytes;
      });
    }
  }

  void _submit() {
    final request = UpdateUserRequest(
      username: _usernameController.text.trim(),
      avatar: _selectedAvatar,
    );

    context.read<AuthBloc>().add(UpdateUserEvent(request, widget.userData!.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: AppWeights.semiBold,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UpdateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.linen,
                    content: PoppinText(
                      text: state.message,
                      styles: StyleText(color: AppColors.ufoGreen),
                    ),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DesktopMainScaffold(index: 2),
                  ),
                );
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bagian Foto Profil
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          children: [
                            ClipOval(
                              child: _avatarBytes != null
                                  ? Image.memory(
                                      _avatarBytes!,
                                      height: 140,
                                      width: 140,
                                      fit: BoxFit.cover,
                                    )
                                  : (widget.userData?.avatar != null &&
                                        widget.userData!.avatar!.isNotEmpty)
                                  ? Image.network(
                                      widget.userData!.avatar!,
                                      height: 140,
                                      width: 140,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 70,
                                      color: AppColors.mediumGray,
                                    ),
                            ),
                            const Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.lightBlue,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: AppColors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(32),

                    // Judul Bagian: Informasi Akun
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        'Informasi Akun',
                        style: TextStyle(
                          color: AppColors.darkGray,
                          fontSize: 18,
                          fontWeight: AppWeights.bold,
                        ),
                      ),
                    ),
                    // FormField Nama Lengkap
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: const TextStyle(
                            color: AppColors.mediumGray,
                            fontWeight: AppWeights.regular,
                          ),
                          filled: true,
                          fillColor: AppColors.youngGray,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    const Gap(24),
                    // FormField Email
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: widget.userData!.email,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.youngGray,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    // Tombol Simpan
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: state is AuthLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: state is AuthLoading
                            ? CircularProgressIndicator(color: AppColors.white)
                            : PoppinText(
                                text: 'Simpan Perubahan',
                                styles: StyleText(
                                  color: AppColors.white,
                                  size: 18,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
