import 'dart:convert';

class RegisterModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String jenisKelamin;

  RegisterModel(this.name, this.email, this.phoneNumber, this.password,
      this.jenisKelamin);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
      'jenis_kelamin': jenisKelamin,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      map['name'] as String,
      map['email'] as String,
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
    String? email,
    String? phoneNumber,
    String? password,
    String? jenisKelamin,
  }) {
    return RegisterModel(
      name ?? this.name,
      email ?? this.email,
      phoneNumber ?? this.phoneNumber,
      password ?? this.password,
      jenisKelamin ?? this.jenisKelamin,
    );
  }
}
