import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maukos_app/core/handling/response_handling/failure.dart';

import '../../../core/handling/dio_exceptions.dart';
import '../../../core/handling/response_handling/success.dart';
import '../../../core/localstorage/localstorage.dart';
import '../models/penyewaan/penyewaan_request_model.dart';
import 'api_datasources.dart';

class PenyewaanDataSource extends ApiDataSources {
  Future<Either<Failure, Success>> sewaKos(
      PenyewaanRequestModel request) async {
    String token = await LocalStorage.getToken();
    try {
      final response = await dioClient.post(
        "$baseUrl/penyewaan/checkout",
        data: request.toMap(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            "Authorization": "Bearer $token"
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return Right(Success(message: data['meta']['message']));
      }
      throw Exception();
    } on DioError catch (e) {
      final exception = DioException.fromDioError(dioError: e);
      return Left(exception.failure);
    }
  }
}
