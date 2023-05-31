import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String password;
  final String? name;
  final String roles;
  final String token;

  const UserEntity({
    required this.email,
    required this.password,
    this.name,
    required this.roles,
    required this.token,
  });

  @override
  List<Object?> get props => [name, email, password, roles, token];
}
