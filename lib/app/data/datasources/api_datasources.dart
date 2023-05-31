import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maukos_app/core/handling/dio_client.dart';
import 'package:maukos_app/app/data/models/auth/login_model.dart';
import 'package:maukos_app/app/data/models/auth/login_response_model.dart';
import 'package:maukos_app/app/data/models/auth/register_model.dart';
import 'package:maukos_app/app/data/models/auth/register_response_model.dart';
import 'package:maukos_app/core/handling/dio_exceptions.dart';
import 'package:maukos_app/core/handling/response_handling/success.dart';

class ApiDataSources {
  final String baseUrl = "http://10.171.45.16:8000/api";
  final DioClient dioClient;

  ApiDataSources({required this.dioClient});

  Future<Either<String, LoginResponseModel>> login(LoginModel request) async {
    try {
      final response = await dioClient.post(
        '$baseUrl/login',
        data: {
          'email': request.email,
          'password': request.password,
        },
      );

      log(response.toString());

      final result = LoginResponseModel.fromMap(response.data['user']);

      return Right(result);
    } on DioError catch (e) {
      final exception = DioException.fromDioError(dioError: e);
      return Left(exception.failure.message);
    }
  }

  Future<Either<String, Success>> register(RegisterModel request) async {
    try {
      log(request.toMap().toString());
      final response =
          await dioClient.post('$baseUrl/register', data: request.toMap());

      if (response.statusCode == 200) {
        return Right(Success(message: "Register Berhasil"));
      }
      throw Exception();
    } on DioError catch (e) {
      final exception =
          DioException.fromDioError(dioError: e, isRegisterError: true);
      return Left(exception.failure.message);
    }
  }
}
