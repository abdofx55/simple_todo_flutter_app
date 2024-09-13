import 'package:flutter/material.dart';
import 'package:todo/layers/domain/task.dart';
import 'package:todo/layers/data/task_repository.dart';

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
  List<Task> taskList = TaskRepository().getTasks();

  void _addTask() {
    setState(() {});
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
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            return TaskCardWidget(task: taskList[index]);
          },
          clipBehavior: Clip.none,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () {},
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

  const TaskCardWidget({super.key, required this.task});


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
                        task.getTime(),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.work_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
