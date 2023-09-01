import 'dart:convert';

class RegisterModel {
  final String name;
  // final String email;
  final String username;
  final String phoneNumber;
  final String password;
  final String jenisKelamin;

  RegisterModel(this.name, this.username, this.phoneNumber, this.password,
      this.jenisKelamin);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      // 'email': email,
      'username': username,
      'phone_number': phoneNumber,
      'password': password,
      'jenis_kelamin': jenisKelamin,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      map['name'] as String,
      // map['email'] as String,
      map['username'] as String,
      map['phone_number'] as String,
      map['password'] as String,
      map['jenis_kelamin'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  RegisterModel copyWith({
    String? name,
    // String? email,
    String? username,
    String? phoneNumber,
    String? password,
    String? jenisKelamin,
  }) {
    return RegisterModel(
      name ?? this.name,
      // email ?? this.email,
      username ?? this.username,
      phoneNumber ?? this.phoneNumber,
      password ?? this.password,
      jenisKelamin ?? this.jenisKelamin,
    );
  }
}
