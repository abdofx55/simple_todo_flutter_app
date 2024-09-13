import 'package:todo/layers/domain/task.dart';

class TaskRepository{

  List<Task> getTasks(){
    return [
      Task(
        id: 1,
        category: "Work",
        name: "Prepare Presentation",
        time: DateTime(2024, 9, 12, 9, 0),
        // 9:00 AM
        isComplete: false,
      ),
      Task(
        id: 2,
        category: "Personal",
        name: "Morning Jog",
        time: DateTime(2024, 9, 12, 6, 30),
        // 6:30 AM
        isComplete: true,
      ),
      Task(
        id: 3,
        category: "Study",
        name: "Read Flutter Documentation",
        time: DateTime(2024, 9, 12, 11, 0),
        // 11:00 AM
        isComplete: false,
      ),
      Task(
        id: 4,
        category: "Work",
        name: "Client Meeting",
        time: DateTime(2024, 9, 12, 14, 30),
        // 2:30 PM
        isComplete: false,
      ),
      Task(
        id: 5,
        category: "Personal",
        name: "Grocery Shopping",
        time: DateTime(2024, 9, 12, 17, 0),
        // 5:00 PM
        isComplete: false,
      ),
      Task(
        id: 6,
        category: "Health",
        name: "Yoga Session",
        time: DateTime(2024, 9, 12, 7, 30),
        // 7:30 AM
        isComplete: true,
      ),
      Task(
        id: 7,
        category: "Work",
        name: "Submit Report",
        time: DateTime(2024, 9, 12, 16, 0),
        // 4:00 PM
        isComplete: false,
      ),
      Task(
        id: 8,
        category: "Leisure",
        name: "Watch Movie",
        time: DateTime(2024, 9, 12, 20, 0),
        // 8:00 PM
        isComplete: false,
      ),
      Task(
        id: 9,
        category: "Work",
        name: "Team Standup",
        time: DateTime(2024, 9, 12, 10, 30),
        // 10:30 AM
        isComplete: true,
      ),
      Task(
        id: 10,
        category: "Fitness",
        name: "Evening Run",
        time: DateTime(2024, 9, 12, 18, 30),
        // 6:30 PM
        isComplete: false,
      ),
    ];
  }
}