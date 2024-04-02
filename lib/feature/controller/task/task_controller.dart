import 'package:flutter/cupertino.dart';
import 'package:knowunity_todo_app/feature/model/task.dart';

class TaskController extends ChangeNotifier {
  List<Task> tasks = [];

  void addTasks(List<Task> tasks) {
    this.tasks = tasks;
    notifyListeners();
  }

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    final index = tasks.indexOf(task);
    tasks[index] = task.updateTask();
    Future.delayed(const Duration(milliseconds: 500), (){
      notifyListeners();
    });
  }
}
