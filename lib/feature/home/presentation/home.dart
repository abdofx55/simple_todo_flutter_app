import 'package:flutter/material.dart';
import 'package:todo/feature/add_task/presentation/add_task.dart';
import 'package:todo/feature/edit_task/presentation/edit_task.dart';
import 'package:todo/feature/home/data/task_repository.dart';
import 'package:todo/feature/home/domain/task.dart';
import 'package:todo/feature/task_details/presentation/task_details.dart';
import 'package:todo/utils/extensions/date_time.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TaskRepository _taskRepository = TaskRepository();
  List<Task> _tasks = [];

  @override
  void initState() {
    _loadTasks();
    super.initState();
  }

  Future<void> _loadTasks() async {
    List<Task> tasks = await _taskRepository.getAllTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _addTask(Task task) async {
    await _taskRepository.addTask(task);
    _loadTasks();
  }

  void _updateTask(Task task) async {
    Task updatedTask = Task(
        id: task.id,
        category: task.category,
        name: task.name,
        time: task.time,
        isComplete: task.isComplete);
    await _taskRepository.updateTask(updatedTask);
    _loadTasks();
  }

  void _removeTask(Task task) async {
    await _taskRepository.removeTask(task);
    _loadTasks();
  }

  void _onItemPressed(Task task) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => TaskDetails(
          task: task,
          onCompletePressed: () {
            task.markAsComplete();
            _updateTask(task);
            Navigator.pop(context); // Return to the HomeScreen
          },
          onEditPressed: () => _onEditPressed(task),
          onDeletePressed: () {
            _removeTask(task);
            Navigator.pop(context); // Return to the HomeScreen
          },
        ),
        transitionDuration: Duration.zero, // No animation duration
        reverseTransitionDuration: Duration.zero, // No reverse animation
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // No transition animation
        },
      ),
    );
  }

  void _onEditPressed(Task task) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => EditTask(
          initialTask: task,
          onEditTask: (task) {
            _updateTask(task);
          }
        ),
        transitionDuration: Duration.zero, // No animation duration
        reverseTransitionDuration: Duration.zero, // No reverse animation
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // No transition animation
        },
      ),
    );
  }

  void _navigateToAddTask() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AddTask(
            onAddTask: (task) {
              _addTask(task);
            }
        ),
        transitionDuration: Duration.zero, // No animation duration
        reverseTransitionDuration: Duration.zero, // No reverse animation
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // No transition animation
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home'),
      ),
      backgroundColor: Colors.cyanAccent[100],
      body: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
        child: _tasks.isEmpty
            ? const Center(
                child: Text(
                  'You have no tasks today, press \nadd button to add one',
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return TaskCardWidget(
                      task: _tasks[index],
                      onItemPressed: () => _onItemPressed(_tasks[index]),
                      onCompletePressed: () {
                        Task task = _tasks[index];
                        task.markAsComplete();
                        _updateTask(task);
                      },
                      onEditPressed: () => _onEditPressed(_tasks[index]),
                      onDeletePressed: () => _removeTask(_tasks[index]));
                },
                clipBehavior: Clip.none,
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () {
            _navigateToAddTask();
          },
          tooltip: 'Increment',
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TaskCardWidget extends StatelessWidget {
  final Task task;
  final VoidCallback onItemPressed;
  final VoidCallback onCompletePressed;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const TaskCardWidget(
      {super.key,
      required this.task,
      required this.onItemPressed,
      required this.onCompletePressed,
      required this.onEditPressed,
      required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.category,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.deepPurpleAccent,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          task.time.formatTime(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        task.isComplete
                            ? const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text(
                                  'Completed',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                              )
                            : IconButton(
                                icon: const Icon(Icons.check, size: 32),
                                color: Colors.deepPurpleAccent,
                                onPressed: onCompletePressed,
                              ),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 32),
                          color: Colors.deepPurpleAccent,
                          onPressed: onEditPressed,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 32),
                          color: Colors.red,
                          onPressed: onDeletePressed,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
