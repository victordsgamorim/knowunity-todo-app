import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:knowunity_todo_app/feature/model/task.dart';
import 'package:knowunity_todo_app/feature/pages/components/taks_item_checkbox.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task task) onTaskTap;
  final Function(Task task) onDelete;

  const TaskList({
    super.key,
    required this.tasks,
    required this.onTaskTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              extentRatio: .25,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) => onDelete(task),
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  borderRadius: BorderRadius.circular(12),
                  label: 'Delete',
                ),
              ],
            ),
            child: TaskItemCheckbox(
              key: UniqueKey(),
              task: task,
              onTap: () => onTaskTap(task),
            ),
          );
        });
  }
}
