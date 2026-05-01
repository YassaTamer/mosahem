import 'package:intl/intl.dart';

class DateHelper {
  static String format(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('d MMM yyyy').format(parsedDate);
    } catch (e) {
      return date; // fallback لو حصل error
    }
  }

  static String formatNumeric(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}
