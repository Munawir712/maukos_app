// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:maukos_app/app/domain/entities/auth/user_entity.dart';

class LoginResponseModel {
  final String name;
  final String email;
  // final String password;
  final String roles;
  final String token;

  LoginResponseModel({
    required this.name,
    required this.email,
    // required this.password,
    required this.roles,
    required this.token,
  });

  UserEntity toEntity() => UserEntity(
        email: email,
        name: name,
        token: token,
        password: '',
        roles: roles,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      // 'password': password,
      'roles': roles,
      'token': token,
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      name: map['name'] as String,
      email: map['email'] as String,
      // password: map['password'] as String,
      roles: map['roles'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) =>
      LoginResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
