import 'package:flutter/material.dart';
import 'package:todo/feature/home/data/task_repository.dart';
import 'package:todo/feature/home/domain/task.dart';
import 'package:todo/utils/extensions/date_time.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            inversePrimary: Colors.deepPurpleAccent,
            seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 21.0),
            centerTitle: true),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TaskRepository _taskRepository = TaskRepository();
  List<Task> _tasks = [];
  int _counter = 1;

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

  void _addTask() async {
    Task newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch,
        category: 'Category $_counter',
        name: 'Name ${_counter++}',
        time: DateTime.now(),
        isComplete: false);
    await _taskRepository.addTask(newTask);
    _loadTasks();
  }

  void _removeTask(Task task) async {
    await _taskRepository.removeTask(task);
    _loadTasks();
  }

  void _markTaskAsComplete(Task task) async {
    Task updatedTask = Task(
        id: task.id,
        category: task.category,
        name: task.name,
        time: task.time,
        isComplete: true);
    await _taskRepository.updateTask(updatedTask);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.cyanAccent[100],
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
        child: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            return TaskCardWidget(
                task: _tasks[index],
                onCompletePressed: () {
                  _markTaskAsComplete(_tasks[index]);
                },
                onDeletePressed: () {
                  _removeTask(_tasks[index]);
                });
          },
          clipBehavior: Clip.none,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () {
            _addTask();
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
  final VoidCallback onCompletePressed;
  final VoidCallback onDeletePressed;

  const TaskCardWidget(
      {super.key,
      required this.task,
      required this.onCompletePressed,
      required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
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
                      Visibility(
                        visible: task.isComplete,
                        child: const Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !task.isComplete,
                        child: IconButton(
                          icon: const Icon(Icons.check, size: 32),
                          color: Colors.deepPurpleAccent,
                          onPressed: onCompletePressed,
                        ),
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
    );
  }
}
