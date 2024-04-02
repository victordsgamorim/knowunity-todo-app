import 'package:flutter/material.dart';
import 'package:knowunity_todo_app/app_widget.dart';
import 'package:knowunity_todo_app/core/injection/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const KnowunityTodoApp());
}
