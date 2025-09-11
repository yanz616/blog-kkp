import 'dart:convert';
import 'dart:io';

import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/data/models/request/post_request.dart';
import 'package:fe/presentation/blocs/posts/post_bloc.dart';
import 'package:fe/presentation/blocs/posts/post_event.dart';
import 'package:fe/presentation/blocs/posts/post_state.dart';
import 'package:fe/presentation/views/desktop/navigation/desktop_navigation.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';

class DesktopEditActivityPage extends StatefulWidget {
  const DesktopEditActivityPage({super.key, required this.postData});
  final PostModel postData;

  @override
  State<DesktopEditActivityPage> createState() =>
      _DesktopEditActivityPageState();
}

class _DesktopEditActivityPageState extends State<DesktopEditActivityPage> {
  late TextEditingController _titleController;
  late QuillController _contentController;
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.postData.title);

    // kalau content disimpan sebagai Delta JSON
    try {
      final doc = Document.fromJson(jsonDecode(widget.postData.content));
      _contentController = QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
      );
    } catch (e) {
      // fallback kalau ternyata plain text
      _contentController = QuillController(
        document: Document()..insert(0, widget.postData.content),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
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
    final request = PostRequest(
      title: _titleController.text.trim(),
      content: jsonEncode(_contentController.document.toDelta().toJson()),
      image: _selectedImage, // null = tetap pakai gambar lama
    );

    context.read<PostBloc>().add(UpdatePost(request, id: widget.postData.id));
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 16, left: 12),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back),
        ),
      ),
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
                    content: PoppinText(
                      text: state.message,
                      styles: StyleText(color: Colors.green.shade800),
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
                    backgroundColor: Colors.red.shade50,
                    content: PoppinText(
                      text: state.message,
                      styles: StyleText(color: Colors.red.shade800),
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
                    PoppinText(
                      text: 'Edit Kegiatan',
                      styles: StyleText(
                        size: 28,
                        weight: AppWeights.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    PoppinText(
                      text: 'Ubah detail kegiatan magang Anda',
                      styles: StyleText(size: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 40),

                    // Judul
                    TextFormField(
                      controller: _titleController,
                      decoration: _inputDecoration("Judul Kegiatan"),
                    ),
                    const SizedBox(height: 16),

                    // Deskripsi (pakai Quill)
                    QuillToolbar.simple(
                      configurations: QuillSimpleToolbarConfigurations(
                        controller: _contentController,
                        multiRowsDisplay: false,
                        showAlignmentButtons: true,
                        showBackgroundColorButton: true,
                        showColorButton: true,
                      ),
                    ),

                    const SizedBox(height: 8),
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                          controller: _contentController,
                          padding: EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 20,
                          ),
                        ),
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
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder:
                              (child, animation) => FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: Tween<double>(
                                    begin: 0.95,
                                    end: 1.0,
                                  ).animate(animation),
                                  child: child,
                                ),
                              ),
                          child:
                              _selectedImage != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.file(
                                      File(_selectedImage!.path),
                                      key: ValueKey(_selectedImage!.path),
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : (widget.postData.image != null &&
                                      widget.postData.image!.isNotEmpty)
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      widget.postData.image!,
                                      key: ValueKey(widget.postData.image),
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : const SizedBox(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Tombol simpan
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
                                  'Simpan Perubahan',
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
