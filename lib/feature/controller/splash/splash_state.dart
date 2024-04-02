part of 'splash_bloc.dart';

@immutable
sealed class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SplashEmpty extends SplashState {}

final class SplashLoading extends SplashState {}

final class SplashNotLogged extends SplashState {}

final class SplashLogged extends SplashState {
  final User user;

  SplashLogged(this.user);

  @override
  List<Object?> get props => [user];
}

final class SplashServerError extends SplashState {
  final String message;

  SplashServerError(this.message);

  @override
  List<Object?> get props => [message];
}
