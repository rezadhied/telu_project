import 'package:intl/intl.dart';

class Formatter {
  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }
}
