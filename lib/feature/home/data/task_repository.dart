import 'package:todo/feature/home/domain/task.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TaskRepository {
  static const String _taskKey =
      'tasks'; // Key to store tasks in SharedPreferences

  // Get all tasks
  Future<List<Task>> getAllTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? taskData = prefs.getString(_taskKey);

    if (taskData != null) {
      List<dynamic> jsonData = jsonDecode(taskData);
      return jsonData.map((json) => Task.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  // Get a single task by id
  Future<Task?> getTaskById(int id) async {
    List<Task> tasks = await getAllTasks();
    try {
      return tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null; // Return null if no task is found
    }
  }

  // Add a task
  Future<void> addTask(Task task) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Task> tasks = await getAllTasks();

    // Add new task
    tasks.add(task);

    // Save updated list of tasks
    await await prefs.setString(
        _taskKey, jsonEncode(tasks.map((e) => e.toJson()).toList()));
  }

  // Update a task
  Future<void> updateTask(Task updatedTask) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Task> tasks = await getAllTasks();

    // Find task by id and update it
    int index = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;
    }

    // Save updated list of tasks
    await prefs.setString(
        _taskKey, jsonEncode(tasks.map((e) => e.toJson()).toList()));
  }

  // Remove a task
  Future<void> removeTask(Task removedTask) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Task> tasks = await getAllTasks();

    // Find task by id and remove it
    int index = tasks.indexWhere((task) => task.id == removedTask.id);
    if (index != -1) {
      tasks.removeAt(index);
    }

    // Save updated list of tasks
    await prefs.setString(
        _taskKey, jsonEncode(tasks.map((e) => e.toJson()).toList()));
  }
}
