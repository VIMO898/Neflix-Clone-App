import 'package:intl/intl.dart';

String formatToReadableDate(String dateString) {
  final DateTime parsedDate =
      DateFormat('yyyy-MM-dd').tryParse(dateString) ?? DateTime.now();
  return DateFormat.yMMMd().format(parsedDate);
}
