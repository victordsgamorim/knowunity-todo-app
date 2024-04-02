import 'package:dartz/dartz.dart';
import 'package:knowunity_todo_app/core/error/exceptions.dart';
import 'package:knowunity_todo_app/core/error/failures.dart';
import 'package:knowunity_todo_app/core/network/network_info.dart';
import 'package:knowunity_todo_app/core/util/messages.dart';
import 'package:knowunity_todo_app/feature/data/datasource/local/todo_local_datasource.dart';
import 'package:knowunity_todo_app/feature/data/datasource/remote/todo_remote_datasource.dart';
import 'package:knowunity_todo_app/feature/model/reponse/todo_response.dart';
import 'package:knowunity_todo_app/feature/model/task.dart' as task;
import 'package:knowunity_todo_app/feature/model/user.dart';

abstract interface class TodoRepository {
  Future<Either<Failure, List<TodoResponse>>> getAllTasks();

  Future<Either<Failure, User>> checkUserInSharedPreferences();

  Future<List<User>> getAllUsersFromDatabase();

  Future<List<task.Task>> getAllTasksByUserId(int userId);

  saveUserToSharedPreferences(User user);

  deleteUserFromSharedPreferences();

  updateTask(task.Task task, int userId);

  addNewTask(task.Task task, int userId);
}

class TodoRepositoryImpl implements TodoRepository {
  final NetworkInfo _networkInfo;
  final TodoRemoteDatasource _todoRemoteDatasource;
  final TodoLocalDatasource _todoLocalDatasource;

  const TodoRepositoryImpl(
    this._networkInfo,
    this._todoRemoteDatasource,
    this._todoLocalDatasource,
  );

  @override
  Future<Either<Failure, List<TodoResponse>>> getAllTasks() async {
    try {
      if (await _networkInfo.isConnected) {
        final tasks = await _todoRemoteDatasource.getAllTasks();
        await _todoLocalDatasource.splitAndSaveToDatabase(tasks);
        return Right(tasks);
      }

      return const Left(InternetFailure(noConnectionError));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> checkUserInSharedPreferences() async {
    try {
      return Right(await _todoLocalDatasource.checkUserInSharedPreferences());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<List<User>> getAllUsersFromDatabase() =>
      _todoLocalDatasource.getAllUsers();

  @override
  saveUserToSharedPreferences(User user) {
    _todoLocalDatasource.saveUserToSharedPreferences(user);
  }

  @override
  Future<List<task.Task>> getAllTasksByUserId(int userId) {
    return _todoLocalDatasource.getAllTasksByUserId(userId);
  }

  @override
  updateTask(task.Task task, int userId) =>
      _todoLocalDatasource.updateTask(task, userId);

  @override
  addNewTask(task.Task task, int userId) {
    _todoLocalDatasource.addNewTask(task, userId);
  }

  @override
  deleteUserFromSharedPreferences() =>
      _todoLocalDatasource.deleteUserFromSharedPreferences();
}
