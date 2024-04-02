import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:knowunity_todo_app/feature/data/repository/todo_repository.dart';
import 'package:knowunity_todo_app/feature/model/user.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final TodoRepository _todoRepository;

  SplashBloc(this._todoRepository) : super(SplashEmpty()) {
    on<LoadTasksEvent>((event, emit) async {
      emit(SplashLoading());

      final response = await _todoRepository.getAllTasks();

      await response.fold(
        (failure) {
          emit(SplashServerError(failure.message));
        },
        (r) async {
          final isLogged = await _todoRepository.checkUserInSharedPreferences();

          isLogged.fold((_) {
            emit(SplashNotLogged());
          }, (user) {
            emit(SplashLogged(user));
          });

          // emit(SplashSuccess());
        },
      );
    });
  }
}
