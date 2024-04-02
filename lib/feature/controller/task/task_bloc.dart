import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:knowunity_todo_app/feature/data/repository/todo_repository.dart';
import 'package:knowunity_todo_app/feature/model/task.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TodoRepository _todoRepository;

  TaskBloc(this._todoRepository) : super(TaskEmpty()) {
    on<GetTaskByUserId>((event, emit) async {
      emit(TaskLoading());
      await Future.delayed(const Duration(seconds: 1));
      final tasks = await _todoRepository.getAllTasksByUserId(event.userId);
      emit(TaskSuccess(tasks));
    });

    on<UpdateTaskEvent>((event, emit) async {
      _todoRepository.addNewTask(event.task, event.userId);
    });

    on<AddNewTaskEvent>((event, emit) async {
      _todoRepository.updateTask(event.task, event.userId);
    });

    on<LogoutEvent>((event, emit) async {
      _todoRepository.deleteUserFromSharedPreferences();
      emit(TaskLogout());
    });
  }
}
