import 'package:knowunity_todo_app/feature/model/user.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class UserDao {
  void save(User user);

  void saveBatch(List<User> users);

  Future<List<User>> getAll();
}

class UserDaoImpl implements UserDao {
  final Database _db;

  const UserDaoImpl(this._db);

  static const _userTableName = 'userTable';
  static const _id = 'id';

  static const String userTable = 'CREATE TABLE $_userTableName('
      '$_id INTEGER PRIMARY KEY)';

  @override
  save(User user) async {
    await _db.insert(
      _userTableName,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<User>> getAll() async {
    final users = await _db.query(_userTableName);
    return users.map((user) => User.fromMap(user)).toList();
  }

  @override
  void saveBatch(List<User> users) async {
    await _db.transaction((transaction) async {
      for (var user in users) {
        await transaction.insert(
          _userTableName,
          user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }
}
