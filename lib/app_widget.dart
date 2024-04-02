import 'package:flutter/material.dart';
import 'package:knowunity_todo_app/core/route/route.dart';
import 'package:knowunity_todo_app/feature/pages/task_page.dart';

class KnowunityTodoApp extends StatelessWidget {
  const KnowunityTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Knowunity Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
