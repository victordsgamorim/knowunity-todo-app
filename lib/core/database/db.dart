import 'package:knowunity_todo_app/core/database/dao/task_dao.dart';
import 'package:knowunity_todo_app/core/database/dao/user_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'task.db');
  return openDatabase(
    path,
    onCreate: (db, _) {
      db.execute(UserDaoImpl.userTable);
      db.execute(TaskDaoImpl.taskTable);
    },
    version: 1,
  );
}
