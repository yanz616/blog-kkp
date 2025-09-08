import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formatDate(String isoDate) {
    final dateTime = DateTime.parse(
      isoDate,
    ); // parsing dari "2025-09-07T07:03:11.762Z"
    return DateFormat('dd-MMMM-yyyy').format(dateTime);
  }

  /// Helper untuk parsing tanggal dengan fallback
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
