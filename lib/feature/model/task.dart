import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final String title;
  final bool completed;

  const Task({this.id, required this.title, required this.completed});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      completed: map['completed'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed ? 1 : 0,
    };
  }

  Task updateTask() => Task(id: id, title: title, completed: !completed);

  @override
  List<Object?> get props => [id, title, completed];
}
