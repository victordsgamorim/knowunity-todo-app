part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoginEmpty extends LoginState {}

final class LoginSuccess extends LoginState {
  final List<User> users;

  LoginSuccess(this.users);

  @override
  List<Object?> get props => [users];
}
