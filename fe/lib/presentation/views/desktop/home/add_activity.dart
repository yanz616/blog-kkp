import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/data/models/request/post_request.dart';
import 'package:fe/presentation/blocs/posts/post_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_event.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';
import 'package:fe/presentation/views/desktop/navigation/desktop_navigation.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class DesktopAddActivityPage extends StatefulWidget {
  const DesktopAddActivityPage({super.key});

  @override
  State<DesktopAddActivityPage> createState() => _DesktopAddActivityPageState();
}

class _DesktopAddActivityPageState extends State<DesktopAddActivityPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  XFile? _selectedImage;

  @override
  void initState() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile; // langsung aja
      });
    }
  }

  void _submit() {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap pilih gambar terlebih dahulu")),
      );
      return;
    }

    final request = PostRequest(
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      image: _selectedImage,
    );
    context.read<PostBloc>().add(CreatePost(request));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 700,
          padding: const EdgeInsets.all(32.0),
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
          child: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostsSuccess) {
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
                    builder: (context) => DesktopMainScaffold(index: 1),
                  ),
                );
              } else if (state is PostsFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.mutedRed,
                    content: PoppinText(
                      text: state.message,
                      styles: StyleText(color: AppColors.crimson),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Judul Halaman
                    PoppinText(
                      text: 'Tambah Kegiatan',
                      styles: StyleText(
                        size: 28,
                        weight: AppWeights.bold,
                        color: AppColors.darkGray,
                      ),
                    ),
                    const Gap(8.0),
                    PoppinText(
                      text: 'Isi detail kegiatan magang Anda',
                      styles: StyleText(size: 16, color: AppColors.mediumGray),
                    ),
                    const Gap(48.0),

                    // Formulir Input
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Judul Kegiatan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const Gap(16.0),
                    TextFormField(
                      controller: _contentController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Deskripsi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const Gap(24.0),

                    // Upload Foto
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(
                          Icons.photo_library,
                          color: AppColors.oldBlue,
                        ),
                        label: PoppinText(
                          text: 'Unggah Foto',
                          styles: StyleText(color: AppColors.oldBlue),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          side: const BorderSide(
                            color: AppColors.oldBlue,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    const Gap(24.0),

                    //preview foto
                    if (_selectedImage != null) ...[
                      const Gap(16.0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          _selectedImage!.path,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                    const Gap(24),
                    // Tombol Simpan
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is PostsLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightBlue,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: state is PostsLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.white,
                              )
                            : PoppinText(
                                text: 'Simpan',
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
