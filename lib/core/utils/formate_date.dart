import 'package:intl/intl.dart';

String formateDateBydMMMyyyy(DateTime dateTime) {
  return DateFormat('d MMM yyyy').format(dateTime);
}
