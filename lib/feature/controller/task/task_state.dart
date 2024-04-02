part of 'task_bloc.dart';

@immutable
sealed class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TaskEmpty extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskSuccess extends TaskState {
  final List<Task> tasks;

  TaskSuccess(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

final class TaskLogout extends TaskState {}
