import 'dart:typed_data';
import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
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
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian Foto Profil
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: AppColors.lightGray,
                          backgroundImage: _imageBytes != null
                              ? MemoryImage(_imageBytes!)
                              : const NetworkImage('https://i.pravatar.cc/300')
                                    as ImageProvider,
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
                const SizedBox(height: 32),

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
                    // controller: TextEditingController(text: 'Jane Doe'),
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
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
                // FormField Jabatan
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextField(
                    controller: TextEditingController(text: 'Admin'),
                    decoration: InputDecoration(
                      labelText: 'Jabatan',
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
                const SizedBox(height: 24),

                // Judul Bagian: Informasi Kontak
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Informasi Kontak',
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontSize: 18,
                      fontWeight: AppWeights.bold,
                    ),
                  ),
                ),
                // FormField Email
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextField(
                    controller: TextEditingController(
                      text: 'jane.doe@diskominfotikntb.go.id',
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
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                // FormField Nomor Telepon
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextField(
                    controller: TextEditingController(text: '081234567890'),
                    decoration: InputDecoration(
                      labelText: 'Nomor Telepon',
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
                const SizedBox(height: 32),

                // Tombol Simpan
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Simpan Perubahan',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: AppWeights.semiBold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Tombol Logout
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.crimson,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: AppWeights.semiBold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
