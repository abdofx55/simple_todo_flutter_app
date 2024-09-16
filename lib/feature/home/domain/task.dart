class Task {
  final int id;
  final String category;
  final String name;
  late final DateTime time;
  bool isComplete;

  Task({
    required this.id,
    required this.category,
    required this.name,
    required this.time,
    this.isComplete = false,
  });

  void markAsComplete() {
    isComplete = true;
  }

  // Convert the Task
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'time': time.toIso8601String(), // Convert DateTime to ISO 8601 string
      'isComplete': isComplete,
    };
  }

  // Create a Task object from a JSON Map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      category: json['category'],
      name: json['name'],
      time: DateTime.parse(json['time']), // Parse ISO 8601 string back to DateTime
      isComplete: json['isComplete'],
    );
  }

}
