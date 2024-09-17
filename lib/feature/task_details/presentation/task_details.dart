import 'package:flutter/material.dart';
import 'package:todo/feature/home/data/task_repository.dart';
import 'package:todo/feature/home/domain/task.dart';
import 'package:todo/utils/extensions/date_time.dart';

class TaskDetails extends StatefulWidget {
  final Task task;
  final VoidCallback onCompletePressed;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const TaskDetails({
    super.key,
    required this.task,
    required this.onCompletePressed,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.category,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.task.name,
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
                  widget.task.time.formatTime(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.task.isComplete
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
                          onPressed: widget.onCompletePressed,
                        ),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 32),
                    color: Colors.deepPurpleAccent,
                    onPressed: widget.onEditPressed,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 32),
                    color: Colors.red,
                    onPressed: widget.onDeletePressed,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
