import 'package:flutter/material.dart';
import 'package:knowunity_todo_app/feature/model/task.dart';
import 'package:knowunity_todo_app/feature/pages/components/taks_item_checkbox.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task task) onTaskTap;

  const TaskList({
    super.key,
    required this.tasks,
    required this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskItemCheckbox(
            key: UniqueKey(),
            task: task,
            onTap: () => onTaskTap(task),
          );
        });
  }
}
