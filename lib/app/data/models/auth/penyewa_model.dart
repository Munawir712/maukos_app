import 'dart:convert';

class PenyewaModel {
  final int id;
  final int userId;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final String jenisKelamin;
  final dynamic fotoKtp;
  final DateTime createdAt;
  final DateTime updatedAt;

  PenyewaModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.jenisKelamin,
    this.fotoKtp,
    required this.createdAt,
    required this.updatedAt,
  });

  PenyewaModel copyWith({
    int? id,
    int? userId,
    String? name,
    String? username,
    String? email,
    String? phoneNumber,
    String? jenisKelamin,
    dynamic fotoKtp,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PenyewaModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        fotoKtp: fotoKtp ?? this.fotoKtp,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PenyewaModel.fromRawJson(String str) =>
      PenyewaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PenyewaModel.fromJson(Map<String, dynamic> json) => PenyewaModel(
        id: json["id"],
        userId: json["user_id"] is String
            ? int.parse(json['user_id'])
            : json['user_id'],
        name: json["name"],
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        phoneNumber: json["phone_number"],
        jenisKelamin: json["jenis_kelamin"],
        fotoKtp: json["foto_ktp"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "jenis_kelamin": jenisKelamin,
        "foto_ktp": fotoKtp,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
