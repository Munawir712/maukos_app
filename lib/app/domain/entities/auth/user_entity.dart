import 'package:equatable/equatable.dart';

import '../../../data/models/auth/penyewa_model.dart';

class UserEntity extends Equatable {
  final String email;
  final String password;
  final String username;
  final String? name;
  final String roles;
  final String token;
  final PenyewaModel penyewa;

  const UserEntity({
    required this.email,
    required this.password,
    required this.username,
    this.name,
    required this.roles,
    required this.token,
    required this.penyewa,
  });

  @override
  List<Object?> get props =>
      [name, email, password, username, roles, token, penyewa];
}
