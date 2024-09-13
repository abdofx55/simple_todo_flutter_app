import 'package:intl/intl.dart';

class Task {
  final int id;
  final String category;
  final String name;
  late final DateTime _time;
  bool isComplete;

  Task({
    required this.id,
    required this.category,
    required this.name,
    required DateTime time,
    this.isComplete = false,
  }) : _time = time;

  String getTime() {
    return DateFormat('hh:mm a').format(_time);
  }

  void markAsComplete() {
    isComplete = true;
  }
}
