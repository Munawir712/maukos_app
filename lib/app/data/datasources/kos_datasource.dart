import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maukos_app/app/data/models/kos/kos_response_model.dart';
import 'package:maukos_app/core/handling/dio_exceptions.dart';

import 'api_datasources.dart';

class KosDataSource extends ApiDataSources {
  // KosDataSource({required super.dioClient});
  Future<Either<String, List<KosResponseModel>>> getAllKos(
      {String? param}) async {
    try {
      final response = await dioClient.get(
        '$baseUrl/kosan?alamat=$param',
        options: Options(
          headers: {'Accept': 'application/json', 'Connection': 'Keep-Alive'},
        ),
      );

      if (response.statusCode == 200) {
        // final data = response.data['data']['data'];
        final data = response.data['data'];
        List<KosResponseModel> kosList = List<KosResponseModel>.from(
            data.map((kos) => KosResponseModel.fromJson(kos)));
        return Right(kosList);
      }
      throw Exception();
    } on DioError catch (e) {
      final exception =
          DioException.fromDioError(dioError: e, isRegisterError: true);
      return Left(exception.failure.message);
    }
  }

  Future<Either<String, List<KosResponseModel>>> searchKos(
      String alamat) async {
    try {
      final response = await dioClient.get(
        '$baseUrl/kosan?alamat=$alamat',
        options: Options(
          headers: {'Accept': 'application/json', 'Connection': 'Keep-Alive'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data']['data'];
        List<KosResponseModel> kosList = List<KosResponseModel>.from(
            data.map((kos) => KosResponseModel.fromJson(kos)));

        return Right(kosList);
      }
      throw Exception();
    } on DioError catch (e) {
      final exception =
          DioException.fromDioError(dioError: e, isRegisterError: true);
      return Left(exception.failure.message);
    }
  }
}
