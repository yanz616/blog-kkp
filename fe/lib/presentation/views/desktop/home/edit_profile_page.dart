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
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 16, left: 12),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Foto profil (rounded avatar)
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                _avatarBytes != null
                                    ? MemoryImage(_avatarBytes!)
                                    : (widget.userData?.avatar != null &&
                                        widget.userData!.avatar!.isNotEmpty)
                                    ? NetworkImage(widget.userData!.avatar!)
                                    : null,
                            backgroundColor: AppColors.youngGray,
                            child:
                                (widget.userData?.avatar == null ||
                                            widget.userData!.avatar!.isEmpty) &&
                                        _avatarBytes == null
                                    ? const Icon(
                                      Icons.person,
                                      size: 60,
                                      color: AppColors.mediumGray,
                                    )
                                    : null,
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

                    const Gap(40),

                    // Judul section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: PoppinText(
                        text: "Informasi Akun",
                        styles: StyleText(
                          size: 18,
                          weight: AppWeights.bold,
                          color: AppColors.darkGray,
                        ),
                      ),
                    ),
                    const Gap(16),

                    // Input Username
                    TextField(
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
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const Gap(20),

                    // Input Email (readonly)
                    TextField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: widget.userData!.email,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          color: AppColors.mediumGray,
                          fontWeight: AppWeights.regular,
                        ),
                        filled: true,
                        fillColor: AppColors.youngGray,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const Gap(40),

                    // Tombol simpan
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: state is AuthLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightBlue,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child:
                            state is AuthLoading
                                ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                                : PoppinText(
                                  text: 'Simpan Perubahan',
                                  styles: StyleText(
                                    color: AppColors.white,
                                    size: 18,
                                    weight: AppWeights.semiBold,
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
