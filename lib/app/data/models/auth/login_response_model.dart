// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:maukos_app/app/data/models/auth/penyewa_model.dart';
import 'package:maukos_app/app/domain/entities/auth/user_entity.dart';

class LoginResponseModel {
  final String name;
  final String email;
  final String username;
  final String roles;
  final String token;
  final PenyewaModel penyewa;

  LoginResponseModel({
    required this.name,
    required this.email,
    required this.username,
    required this.roles,
    required this.token,
    required this.penyewa,
  });

  UserEntity toEntity() => UserEntity(
        email: email,
        name: name,
        username: username,
        token: token,
        password: '',
        roles: roles,
        penyewa: penyewa,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'username': email,
      'roles': roles,
      'token': token,
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      name: map['name'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      roles: map['roles'] as String,
      token: map['token'] as String,
      penyewa: PenyewaModel.fromJson(map['penyewa']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) =>
      LoginResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
