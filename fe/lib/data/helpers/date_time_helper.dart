import 'package:intl/intl.dart';

class DateTimeHelper {
  /// Format ke bentuk "sabtu, 06 september 2025"
  // static String formatLongDate(String isoDate) {
  //   final dateTime = DateTime.parse(isoDate).toLocal();
  //   return DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(dateTime);
  // }
  static String formatLongDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return "-";

    try {
      final dateTime = DateTime.parse(isoDate).toLocal();
      return DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(dateTime);
    } catch (_) {
      return isoDate; // fallback string apa adanya
    }
  }

  /// Format ke bentuk "06 sep 2025"
  static String formatShortDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat("dd MMM yyyy", "id_ID").format(dateTime);
  }

  /// Format ke bentuk "06 september 2025, 14:00"
  static String formatDateTimeLong(String isoDate) {
    final dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat("dd MMMM yyyy, HH:mm", "id_ID").format(dateTime);
  }

  /// Format ke bentuk "04 sep 2025, 14:30"
  static String formatDateTimeShort(String isoDate) {
    final dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat("dd MMM yyyy, HH:mm", "id_ID").format(dateTime);
  }

  /// Format ke bentuk "04/09/2025"
  static String formatSlash(String isoDate) {
    final dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat("dd/MM/yyyy").format(dateTime);
  }

  /// Format ke bentuk "17:40"
  static String formatTime(String isoDate) {
    final dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat("HH:mm").format(dateTime);
  }

  /// Helper parsing tanggal dengan fallback
  static DateTime? parseDate(dynamic dateStr) {
    if (dateStr == null) return null;

    try {
      // coba parse ISO8601 langsung
      return DateTime.tryParse(dateStr.toString());
    } catch (_) {
      try {
        // fallback ke format Laravel "yyyy-MM-dd HH:mm:ss"
        return DateFormat(
          "yyyy-MM-dd HH:mm:ss",
        ).parse(dateStr.toString(), true).toLocal();
      } catch (_) {
        return null; // kalau gagal semua, biarkan null
      }
    }
  }
}
