part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskEmpty extends TaskState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

final class TaskLoading extends TaskState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

final class TaskSuccess extends TaskState {
  final List<Task> tasks;

  TaskSuccess(this.tasks);
}

final class TaskLogout extends TaskState with EquatableMixin {
  @override
  List<Object?> get props => [];
}
