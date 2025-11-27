import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/utils/local_storage.dart';
import 'package:fe/data/helpers/date_time_helper.dart';
import 'package:fe/data/models/user/user.dart';
import 'package:fe/presentation/views/desktop/home/edit_profile_page.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DesktopProfilePage extends StatefulWidget {
  const DesktopProfilePage({super.key});

  @override
  State<DesktopProfilePage> createState() => _DesktopProfilePageState();
}

class _DesktopProfilePageState extends State<DesktopProfilePage> {
  User? userData;

  Future<void> loadUserData() async {
    final token = await LocalStorage.getString() ?? "";
    final id = await LocalStorage.getId() ?? 0;
    final username = await LocalStorage.getUsername() ?? "";
    final email = await LocalStorage.getEmail() ?? "";
    final avatar = await LocalStorage.getAvatar() ?? "";
    final created = await LocalStorage.getCreated() ?? "";
    final isAdmin = await LocalStorage.getIsAdmin() ?? false;
    final internshipStartDate = await LocalStorage.getInternshipStartDate();
    final internshipEndDate = await LocalStorage.getInternshipEndDate();
    final internshipPosition = await LocalStorage.getInternshipPosition();
    final internshipDivision = await LocalStorage.getInternshipDivision();
    final school = await LocalStorage.getSchool();

    if (!mounted) return;

    setState(() {
      userData = User(
        id: id,
        username: username,
        email: email,
        avatar: avatar,
        token: token,
        createdAt: created,
        isAdmin: isAdmin,
        internshipStartDate: internshipStartDate,
        internshipEndDate: internshipEndDate,
        internshipPosition: internshipPosition,
        internshipDivision: internshipDivision,
        school: school,
      );
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
    super.initState();
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.9), size: 18),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PoppinText(
                text: label,
                styles: StyleText(
                  size: 12,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              const Gap(2),
              PoppinText(
                text: value,
                styles: StyleText(
                  size: 14,
                  weight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDurationInfo() {
    if (userData?.internshipStartDate == null ||
        userData?.internshipEndDate == null) {
      return const SizedBox.shrink();
    }

    final startDate = DateTime.parse(userData!.internshipStartDate!);
    final endDate = DateTime.parse(userData!.internshipEndDate!);
    final now = DateTime.now();
    final totalDays = endDate.difference(startDate).inDays;
    final totalMonths = (totalDays / 30).round();

    String statusText;
    Color statusColor;
    IconData statusIcon;

    if (now.isBefore(startDate)) {
      statusText = 'Belum Dimulai';
      statusColor = Colors.orange;
      statusIcon = Icons.schedule;
    } else if (now.isAfter(endDate)) {
      statusText = 'Selesai';
      statusColor = Colors.green;
      statusIcon = Icons.check_circle_outline;
    } else {
      final daysLeft = endDate.difference(now).inDays;
      statusText = 'Berlangsung ($daysLeft hari lagi)';
      statusColor = Colors.lightGreenAccent;
      statusIcon = Icons.play_circle_outline;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 20),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PoppinText(
                  text: 'Status',
                  styles: StyleText(
                    size: 12,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                const Gap(2),
                PoppinText(
                  text: statusText,
                  styles: StyleText(
                    size: 14,
                    weight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: PoppinText(
              text: '$totalMonths Bulan',
              styles: StyleText(
                size: 12,
                weight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Avatar dengan border gradient tipis
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.lightBlue, Color(0xFF50E3C2)],
                ),
              ),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(userData!.avatar.toString()),
              ),
            ),

            const Gap(28.0),

            // Username
            PoppinText(
              text: userData!.username,
              styles: StyleText(
                size: 26,
                weight: FontWeight.bold,
                color: AppColors.darkGray,
              ),
            ),

            const Gap(10.0),

            // Email
            PoppinText(
              text: userData!.email,
              styles: StyleText(size: 16, color: AppColors.mediumGray),
            ),

            const Gap(6.0),

            // Tanggal join
            PoppinText(
              text:
                  "Bergabung pada: ${DateTimeHelper.formatLongDate(userData?.createdAt)}",
              styles: StyleText(size: 14, color: AppColors.mediumGray),
            ),

            const Gap(40),

            // Informasi Periode Magang
            if (userData!.internshipStartDate != null &&
                userData!.internshipEndDate != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A90E2).withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.work_outline_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const Gap(12),
                        PoppinText(
                          text: 'Informasi Magang',
                          styles: StyleText(
                            size: 18,
                            weight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    _buildInfoRow(
                      icon: Icons.school_outlined,
                      label: 'Asal Sekolah/Universitas',
                      value: userData!.school ?? '-',
                    ),
                    const Gap(12),
                    _buildInfoRow(
                      icon: Icons.badge_outlined,
                      label: 'Posisi',
                      value: userData!.internshipPosition ?? '-',
                    ),
                    const Gap(12),
                    _buildInfoRow(
                      icon: Icons.business_outlined,
                      label: 'Divisi',
                      value: userData!.internshipDivision ?? '-',
                    ),
                    const Gap(12),
                    _buildInfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Periode',
                      value:
                          '${DateTimeHelper.formatShortDate(userData!.internshipStartDate ?? "")} - ${DateTimeHelper.formatShortDate(userData!.internshipEndDate ?? "")}',
                    ),
                    const Gap(12),
                    _buildDurationInfo(),
                  ],
                ),
              ),

            const Gap(24),

            // Tombol Edit Profil
            SizedBox(
              width: double.infinity,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => EditProfilePage(userData: userData),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ).copyWith(
                    overlayColor: WidgetStateProperty.all(
                      AppColors.lightBlue.withValues(alpha: 0.85),
                    ),
                  ),
                  child: PoppinText(
                    text: 'Edit Profil',
                    styles: StyleText(
                      size: 18,
                      color: AppColors.white,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
