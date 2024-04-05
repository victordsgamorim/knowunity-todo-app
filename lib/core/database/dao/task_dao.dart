import 'package:knowunity_todo_app/feature/model/reponse/todo_response.dart';
import 'package:knowunity_todo_app/feature/model/task.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class TaskDao {
  save(Task task, int userId);

  Future<List<Task>> getAll();

  Future<List<Task>> getAllByUserId(int userId);

  saveBatch(List<TodoResponse> tasks);

  update(Task task, int userId);

  delete(int id);
}

class TaskDaoImpl implements TaskDao {
  final Database _db;

  const TaskDaoImpl(this._db);

  static const _taskTableName = 'taskTable';
  static const _title = 'title';
  static const _id = 'id';
  static const _completed = 'completed';
  static const _userId = 'userId';

  static const String taskTable = 'CREATE TABLE $_taskTableName('
      '$_id INTEGER PRIMARY KEY,'
      '$_title TEXT,'
      '$_completed INTEGER,'
      '$_userId INTEGER,'
      'FOREIGN KEY ($_userId) REFERENCES USER(id))';

  @override
  save(Task task, int userId) async {
    await _db.insert(_taskTableName, task.toMap()..['userId'] = userId,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Task>> getAll() async {
    final List<Map<String, dynamic>> tasks = await _db.query(_taskTableName);
    return tasks.map((task) => Task.fromMap(task)).toList();
  }

  @override
  Future<List<Task>> getAllByUserId(int userId) async {
    final List<Map<String, dynamic>> tasks = await _db.query(
      _taskTableName,
      where: '$_userId = ?',
      whereArgs: [userId],
    );
    return tasks.map((task) => Task.fromMap(task)).toList();
  }

  @override
  saveBatch(List<TodoResponse> tasks) async {
    await _db.transaction((transaction) async {
      for (var task in tasks) {
        await transaction.insert(
          _taskTableName,
          Task(id: task.id, title: task.title, completed: task.completed)
              .toMap()
            ..['userId'] = task.userId,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  @override
  update(Task task, int userId) async {
    final t = task.toMap()..['userId'] = userId;
    await _db.update(_taskTableName, t, where: 'id = ?', whereArgs: [task.id]);
  }

  @override
  delete(int id) async {
    await _db.delete(_taskTableName, where: 'id = ?', whereArgs: [id]);
  }
}
