import 'package:equatable/equatable.dart';

class TodoResponse extends Equatable {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const TodoResponse({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TodoResponse.fromJson(Map<String, dynamic> json) {
    return TodoResponse(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  @override
  List<Object?> get props => [
        userId,
        id,
        title,
        completed,
      ];
}
