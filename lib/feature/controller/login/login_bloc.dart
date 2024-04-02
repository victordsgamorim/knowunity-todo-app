import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:knowunity_todo_app/feature/data/repository/todo_repository.dart';
import 'package:knowunity_todo_app/feature/model/user.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TodoRepository _todoRepository;

  LoginBloc(this._todoRepository) : super(LoginEmpty()) {
    on<LoadUsersFromDatabaseEvent>((event, emit) async {
      final response = await _todoRepository.getAllUsersFromDatabase();
      emit(LoginSuccess(response));
    });

    on<SaveUserToSharedPreferencesEvent>((event, emit) async {
      await _todoRepository.saveUserToSharedPreferences(event.user);
    });
  }
}
