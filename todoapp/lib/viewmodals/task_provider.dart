import 'package:flutter/material.dart';
import 'package:todoapp/modals/task_modal.dart';  // Task model import

class TaskProvider extends ChangeNotifier {
  // 📦 1. State - Data store karne ki jagah
  final List<Task> _tasks = [];  // Private variable (_ means private)

  // Getter - Private data ko read karne ka public method
  List<Task> get tasks => _tasks;

  // ➕ 2. Add Task Function
  void addTask(String title) {
    // Naya task banao
    final newTask = Task(
      title: title,
      createdAt: DateTime.now(),
    );

    _tasks.add(newTask);  // List mein add karo
    notifyListeners();     // UI ko batao - "Hey UI, update ho ja!"
  }

  // ✅ 3. Toggle Task Status
  void toggleTask(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;  // Complete <-> Incomplete
    notifyListeners();  // UI update
  }

  // 🗑️ 4. Delete Task
  void deleteTask(int index) {
    _tasks.removeAt(index);  // List se hatao
    notifyListeners();       // UI update
  }
}