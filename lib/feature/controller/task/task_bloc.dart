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

  List<Task> _tasks = [];

  TaskBloc(this._todoRepository) : super(TaskEmpty()) {
    on<GetTaskByUserId>((event, emit) async {
      emit(TaskLoading());
      await Future.delayed(const Duration(seconds: 1));
      final tasks = await _todoRepository.getAllTasksByUserId(event.userId);
      _tasks = tasks;
      emit(TaskSuccess(tasks));
    });
    on<UpdateTaskEvent>((event, emit) async {
      final index = _tasks.indexOf(event.task);
      final updatedTask = event.task.updateTask();
      _tasks[index] = updatedTask;
      _todoRepository.updateTask(updatedTask, event.userId);
      await Future.delayed(const Duration(milliseconds: 400), () {
        emit(TaskSuccess(_tasks));
      });
    });
    on<AddNewTaskEvent>((event, emit) async {
      final newTask = event.task;
      _tasks.add(newTask);
      _todoRepository.addNewTask(newTask, event.userId);
      emit(TaskSuccess(_tasks));
    });
    on<DeleteTaskEvent>((event, emit) async {
      final taskId = event.taskId;
      _tasks.removeWhere((element) => element.id == taskId);
      _todoRepository.deleteTask(taskId);
      emit(TaskSuccess(_tasks));
    });
    on<LogoutEvent>((event, emit) async {
      _todoRepository.deleteUserFromSharedPreferences();
      emit(TaskLogout());
    });
  }
}
