import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:knowunity_todo_app/feature/model/task.dart';

class TaskItemCheckbox extends StatefulWidget {
  final Task task;
  final VoidCallback onTap;

  const TaskItemCheckbox({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  State<TaskItemCheckbox> createState() => _TaskItemCheckboxState();
}

class _TaskItemCheckboxState extends State<TaskItemCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    isChecked = widget.task.completed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        title: Text(widget.task.title),
        value: isChecked,
        onChanged: (_) {
          setState(() {
            isChecked = !isChecked;
            widget.onTap();
          });
        },
      ),
    );
  }
}
