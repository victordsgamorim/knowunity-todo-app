part of 'task_bloc.dart';

@immutable
sealed class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetTaskByUserId extends TaskEvent {
  final int userId;

  GetTaskByUserId(this.userId);

  @override
  List<Object?> get props => [userId];
}

final class AddNewTaskEvent extends TaskEvent {
  final Task task;
  final int userId;

  AddNewTaskEvent(this.task, this.userId);

  @override
  List<Object?> get props => [task, userId];
}

final class UpdateTaskEvent extends TaskEvent {
  final Task task;
  final int userId;

  UpdateTaskEvent(this.task, this.userId);

  @override
  List<Object?> get props => [task, userId];
}

final class DeleteTaskEvent extends TaskEvent {
  final int taskId;

  DeleteTaskEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

final class LogoutEvent extends TaskEvent {}
