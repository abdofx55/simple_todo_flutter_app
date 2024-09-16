import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {

  String formatTime() =>
      DateFormat('hh:mm a').format(this);

}