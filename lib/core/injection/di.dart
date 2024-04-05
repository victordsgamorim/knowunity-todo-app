import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:knowunity_todo_app/core/database/dao/task_dao.dart';
import 'package:knowunity_todo_app/core/database/dao/user_dao.dart';
import 'package:knowunity_todo_app/core/database/db.dart';
import 'package:knowunity_todo_app/core/network/network_info.dart';
import 'package:knowunity_todo_app/feature/controller/login/login_bloc.dart';
import 'package:knowunity_todo_app/feature/controller/splash/splash_bloc.dart';
import 'package:knowunity_todo_app/feature/controller/task/task_bloc.dart';
import 'package:knowunity_todo_app/feature/data/datasource/local/todo_local_datasource.dart';
import 'package:knowunity_todo_app/feature/data/datasource/remote/todo_remote_datasource.dart';
import 'package:knowunity_todo_app/feature/data/repository/todo_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

setup() async {
  /** BLOC **/
  GetIt.I.registerFactory(() => SplashBloc(GetIt.I()));
  GetIt.I.registerFactory(() => LoginBloc(GetIt.I()));
  GetIt.I.registerFactory(() => TaskBloc(GetIt.I()));

  /** REPOSITORY **/
  GetIt.I.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      GetIt.I(),
      GetIt.I(),
      GetIt.I(),
    ),
  );

  /** REMOTE DATASOURCE **/
  GetIt.I.registerLazySingleton<TodoRemoteDatasource>(
      () => TodoRemoteDatasourceImpl(GetIt.I()));

  /** LOCAL DATASOURCE **/
  GetIt.I.registerLazySingleton<TodoLocalDatasource>(
      () => TodoLocalDatasourceImpl(GetIt.I(), GetIt.I(), GetIt.I()));

  /** DAO **/
  GetIt.I.registerLazySingleton<UserDao>(() => UserDaoImpl(GetIt.I()));
  GetIt.I.registerLazySingleton<TaskDao>(() => TaskDaoImpl(GetIt.I()));

  /** CORE **/
  GetIt.I.registerLazySingleton(() => Connectivity());
  GetIt.I.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(GetIt.I()));
  GetIt.I.registerLazySingleton(() => http.Client());
  final db = await getDatabase();
  GetIt.I.registerLazySingleton<Database>(() => db);
  final sharedPreferences = await SharedPreferences.getInstance();
  GetIt.I.registerLazySingleton(() => sharedPreferences);
}
