import 'package:intl/intl.dart';

class DateTimeHelper {
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
