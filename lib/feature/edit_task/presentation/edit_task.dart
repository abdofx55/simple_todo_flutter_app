import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/feature/home/domain/task.dart';
import 'package:todo/utils/extensions/date_time.dart';

class EditTask extends StatefulWidget {
  final Task initialTask;
  final Function(Task) onEditTask;

  const EditTask({
    super.key,
    required this.initialTask,
    required this.onEditTask,
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController _categoryController;
  late TextEditingController _nameController;
  late DateTime _selectedTime; // Variable to store the selected time

  @override
  void initState() {
    super.initState();
    _categoryController =
        TextEditingController(text: widget.initialTask.category);
    _nameController = TextEditingController(text: widget.initialTask.name);
    _selectedTime = widget.initialTask.time; // Initialize the selected time
  }

  // Function to pick a time
  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = DateTime(
          _selectedTime.year,
          _selectedTime.month,
          _selectedTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
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
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.deepPurpleAccent),
                const SizedBox(width: 8),
                Text(
                  _selectedTime.formatTime(), // Display the formatted time
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _pickTime, // Opens time picker
                  child: const Text('Edit Time'),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _categoryController.text.isNotEmpty) {
                      widget.onEditTask(Task(
                          id: widget.initialTask.id,
                          category: _categoryController.text,
                          name: _nameController.text,
                          time: _selectedTime));
                      Navigator.pop(context); // Return to the previous screen
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
