import 'dart:convert';
import 'dart:io';

import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/data/models/request/post_request.dart';
import 'package:fe/presentation/blocs/posts/post_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_event.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';
import 'package:fe/presentation/views/desktop/navigation/desktop_navigation.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class DesktopAddActivityPage extends StatefulWidget {
  const DesktopAddActivityPage({super.key});

  @override
  State<DesktopAddActivityPage> createState() => _DesktopAddActivityPageState();
}

class _DesktopAddActivityPageState extends State<DesktopAddActivityPage> {
  late TextEditingController _titleController;
  late quill.QuillController _contentController;
  XFile? _selectedImage;

  @override
  void initState() {
    _titleController = TextEditingController();
    _contentController = quill.QuillController.basic();
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
        _selectedImage = pickedFile;
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
      content: jsonEncode(_contentController.document.toDelta().toJson()),
      image: _selectedImage,
    );
    context.read<PostBloc>().add(CreatePost(request));
  }

  InputDecoration _inputDecoration(String label, {bool alignHint = false}) {
    return InputDecoration(
      labelText: label,
      alignLabelWithHint: alignHint,
      labelStyle: TextStyle(color: Colors.grey[600]),
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[600]!, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Center(
        child: Container(
          width: 700,
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostsSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green.shade50,
                    content: Text(
                      state.message,
                      style: TextStyle(color: Colors.green.shade800),
                    ),
                  ),
                );
                Navigator.pop(context);
              } else if (state is PostsFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red.shade50,
                    content: Text(
                      state.message,
                      style: TextStyle(color: Colors.red.shade800),
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
                    Text(
                      'Tambah Kegiatan',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Isi detail kegiatan magang Anda',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 40),

                    // Form Judul
                    TextFormField(
                      controller: _titleController,
                      decoration: _inputDecoration("Judul Kegiatan"),
                    ),
                    const SizedBox(height: 16),

                    // Form Deskripsi (Quill)
                    Text(
                      "Deskripsi",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        children: [
                          quill.QuillToolbar.simple(
                            configurations:
                                quill.QuillSimpleToolbarConfigurations(
                                  controller: _contentController,
                                  multiRowsDisplay: false,
                                  showAlignmentButtons: true,
                                  showBackgroundColorButton: true,
                                  showColorButton: true,
                                ),
                          ),
                          SizedBox(
                            height: 200,
                            child: quill.QuillEditor.basic(
                              configurations: quill.QuillEditorConfigurations(
                              padding: EdgeInsets.all(16),
                                controller: _contentController,
                                placeholder: "Tulis deskripsi kegiatan...",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Upload Foto
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child:
                            _selectedImage == null
                                ? const DottedBorderPlaceholder()
                                : ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(
                                    File(_selectedImage!.path),
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Tombol Simpan
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is PostsLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 4,
                        ),
                        child:
                            state is PostsLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Text(
                                  'Simpan',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
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

// widget placeholder upload
class DottedBorderPlaceholder extends StatelessWidget {
  const DottedBorderPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedBorderPainter(),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 48,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 8),
            Text(
              "Klik untuk unggah foto",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final paint =
        Paint()
          ..color = Colors.grey[600]!
          ..strokeWidth = 1.6
          ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(16),
    );

    final path = Path()..addRRect(rect);
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final segment = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
