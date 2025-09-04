import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/constants/app_font_weigts.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DesktopAddEditActivityPage extends StatefulWidget {
  final bool isEditing;

  const DesktopAddEditActivityPage({super.key, this.isEditing = false});

  @override
  State<DesktopAddEditActivityPage> createState() =>
      _DesktopAddEditActivityPageState();
}

class _DesktopAddEditActivityPageState
    extends State<DesktopAddEditActivityPage> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Judul Halaman
                PoppinText(
                  text: widget.isEditing ? 'Edit Kegiatan' : 'Tambah Kegiatan',
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
                  controller: _descController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const Gap(24.0),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: PoppinText(
                      text: widget.isEditing ? 'Simpan Perubahan' : 'Simpan',
                      styles: StyleText(size: 18, color: AppColors.white),
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
