import 'package:fe/core/constants/app_colors.dart';
import 'package:fe/core/utils/local_storage.dart';
import 'package:fe/data/helpers/date_time_helper.dart';
import 'package:fe/data/models/user/user.dart';
import 'package:fe/presentation/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MobileProfilePage extends StatefulWidget {
  const MobileProfilePage({super.key});

  @override
  State<MobileProfilePage> createState() => _MobileProfilePageState();
}

class _MobileProfilePageState extends State<MobileProfilePage> {
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

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lightBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.lightBlue,
              size: 22,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PoppinText(
                  text: label,
                  styles: StyleText(
                    size: 12,
                    color: AppColors.mediumGray,
                  ),
                ),
                const Gap(2),
                PoppinText(
                  text: value,
                  styles: StyleText(
                    size: 14,
                    weight: FontWeight.w600,
                    color: AppColors.darkGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
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
    Color bgColor;

    if (now.isBefore(startDate)) {
      statusText = 'Belum Dimulai';
      statusColor = Colors.orange;
      bgColor = Colors.orange.withValues(alpha: 0.1);
      statusIcon = Icons.schedule;
    } else if (now.isAfter(endDate)) {
      statusText = 'Selesai';
      statusColor = Colors.green;
      bgColor = Colors.green.withValues(alpha: 0.1);
      statusIcon = Icons.check_circle_outline;
    } else {
      final daysLeft = endDate.difference(now).inDays;
      statusText = 'Berlangsung';
      statusColor = AppColors.lightBlue;
      bgColor = AppColors.lightBlue.withValues(alpha: 0.1);
      statusIcon = Icons.play_circle_outline;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.lightBlue,
            const Color(0xFF50E3C2),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightBlue.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    statusIcon,
                    color: Colors.white,
                    size: 24,
                  ),
                  const Gap(8),
                  PoppinText(
                    text: statusText,
                    styles: StyleText(
                      size: 16,
                      weight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
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
          const Gap(12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 16,
                ),
                const Gap(8),
                PoppinText(
                  text:
                      '${DateTimeHelper.formatShortDate(userData!.internshipStartDate ?? "")} - ${DateTimeHelper.formatShortDate(userData!.internshipEndDate ?? "")}',
                  styles: StyleText(
                    size: 13,
                    weight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const Gap(20),
            // Avatar dengan border gradient
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.lightBlue, Color(0xFF50E3C2)],
                ),
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(userData!.avatar.toString()),
              ),
            ),
            const Gap(20),

            // Username
            PoppinText(
              text: userData!.username,
              styles: StyleText(
                size: 24,
                weight: FontWeight.bold,
                color: AppColors.darkGray,
              ),
            ),
            const Gap(6),

            // Email
            PoppinText(
              text: userData!.email,
              styles: StyleText(size: 14, color: AppColors.mediumGray),
            ),
            const Gap(4),

            // Tanggal join
            PoppinText(
              text:
                  "Bergabung ${DateTimeHelper.formatLongDate(userData?.createdAt)}",
              styles: StyleText(size: 12, color: AppColors.mediumGray),
            ),

            const Gap(24),

            // Informasi Periode Magang
            if (userData!.internshipStartDate != null &&
                userData!.internshipEndDate != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.lightBlue.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.work_outline_rounded,
                      color: AppColors.lightBlue,
                      size: 20,
                    ),
                    const Gap(8),
                    PoppinText(
                      text: 'Informasi Magang',
                      styles: StyleText(
                        size: 16,
                        weight: FontWeight.bold,
                        color: AppColors.darkGray,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(16),
              _buildInfoCard(
                icon: Icons.school_outlined,
                label: 'Asal Sekolah/Universitas',
                value: userData!.school ?? '-',
              ),
              const Gap(12),
              _buildInfoCard(
                icon: Icons.badge_outlined,
                label: 'Posisi',
                value: userData!.internshipPosition ?? '-',
              ),
              const Gap(12),
              _buildInfoCard(
                icon: Icons.business_outlined,
                label: 'Divisi',
                value: userData!.internshipDivision ?? '-',
              ),
              const Gap(16),
              _buildStatusCard(),
              const Gap(24),
            ],

            // Tombol Edit Profil
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Logika navigasi ke halaman edit profil
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: PoppinText(
                  text: 'Edit Profil',
                  styles: StyleText(
                    size: 16,
                    color: AppColors.white,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
