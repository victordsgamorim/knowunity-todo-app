import 'package:knowunity_todo_app/core/database/dao/task_dao.dart';
import 'package:knowunity_todo_app/core/database/dao/user_dao.dart';
import 'package:knowunity_todo_app/core/error/exceptions.dart';
import 'package:knowunity_todo_app/core/util/messages.dart';
import 'package:knowunity_todo_app/feature/model/reponse/todo_response.dart';
import 'package:knowunity_todo_app/feature/model/task.dart';
import 'package:knowunity_todo_app/feature/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String userSp = 'user';

abstract interface class TodoLocalDatasource {
  Future<User> checkUserInSharedPreferences();

  Future<List<Task>> getAllTasksByUserId(int userId);

  Future<List<User>> getAllUsers();

  addNewTask(Task task, int userId);

  updateTask(Task task, int userId);

  splitAndSaveToDatabase(List<TodoResponse> tasks);

  saveUserToSharedPreferences(User user);

  deleteUserFromSharedPreferences();
}

class TodoLocalDatasourceImpl extends TodoLocalDatasource {
  final UserDao _userDao;
  final TaskDao _taskDao;
  final SharedPreferences _sharedPreferences;

  TodoLocalDatasourceImpl(
    this._userDao,
    this._taskDao,
    this._sharedPreferences,
  );

  @override
  splitAndSaveToDatabase(List<TodoResponse> tasks) async {
    Set<User> uL = {};
    List<Task> tL = [];
    for (var task in tasks) {
      final u = User.defaultName(task.userId);
      final t = Task(id: task.id, title: task.title, completed: task.completed);
      uL.add(u);
      tL.add(t);
    }

    _taskDao.saveBatch(tasks);
    _userDao.saveBatch(uL.toList());

    final s = await _userDao.getAll();
  }

  @override
  Future<User> checkUserInSharedPreferences() async {
    final user = _sharedPreferences.getInt(userSp);
    if (user != null) return User.defaultName(user);
    throw const CacheException(noUserInSharedPreferences);
  }

  @override
  Future<List<User>> getAllUsers() => _userDao.getAll();

  @override
  saveUserToSharedPreferences(User user) =>
      _sharedPreferences.setInt(userSp, user.id);

  @override
  Future<List<Task>> getAllTasksByUserId(int userId) {
    return _taskDao.getAllByUserId(userId);
  }

  @override
  updateTask(Task task, int userId) => _taskDao.update(task, userId);

  @override
  addNewTask(Task task, int userId) => _taskDao.save(task, userId);

  @override
  deleteUserFromSharedPreferences() {
    _sharedPreferences.remove(userSp);
  }
}
