part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final UserEntity user;

  const AuthLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthRegisterSuccess extends AuthState {
  final String message;
  // final UserEntity user;

  const AuthRegisterSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
