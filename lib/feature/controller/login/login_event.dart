part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoadUsersFromDatabaseEvent extends LoginEvent {}

final class SaveUserToSharedPreferencesEvent extends LoginEvent {
  final User user;

  SaveUserToSharedPreferencesEvent(this.user);

  @override
  List<Object?> get props => [user];
}
