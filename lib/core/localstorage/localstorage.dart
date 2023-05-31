import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maukos_app/app/domain/entities/auth/user_entity.dart';

class LocalStorage {
  static Future<void> storeCredentialToLocal(
      UserEntity user, String password) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'password', value: password);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getToken() async {
    String token = '';
    const storage = FlutterSecureStorage();
    final value = await storage.read(key: 'token');
    if (value != null) {
      token = value;
    }
    return token;
  }

  static Future<Either<String, UserEntity>> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();
      if (values['token'] != null) {
        UserEntity dataLogin = UserEntity(
          email: values['email'].toString(),
          password: values['password'].toString(),
          token: values['token'].toString(),
          roles: '',
        );

        return Right(dataLogin);
      }
      throw 'unauthenticated';
    } catch (e) {
      return const Left("Authentication failed");
    }
  }

  static Future<void> clearLocalStorage() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }
}
