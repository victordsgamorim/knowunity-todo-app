import 'package:flutter/material.dart';
import 'package:knowunity_todo_app/feature/model/task.dart';

class TaskDialog extends StatefulWidget {
  final Function(String text) onCreated;

  const TaskDialog({super.key, required this.onCreated});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  late final GlobalKey<FormState> _formState = GlobalKey();
  late final TextEditingController _textEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            final isValid = _formState.currentState!.validate();

            if (!isValid) {
              return;
            }

            widget.onCreated(_textEditingController.text);
            _textEditingController.text = '';
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
      title: const Text("Create new task!"),
      content: Form(
        key: _formState,
        child: TextFormField(
          controller: _textEditingController,
          decoration: const InputDecoration(
            hintText: 'Bake a cake...',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please a write a task";
            }
            return null;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
