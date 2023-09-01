import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maukos_app/app/data/models/history/history_penyewaan_response_model.dart';

import '../../../core/handling/dio_exceptions.dart';
import '../../../core/handling/response_handling/success.dart';
import '../../../core/localstorage/localstorage.dart';
import 'api_datasources.dart';

class HistoryDataSource extends ApiDataSources {
  // HistoryDataSource({required super.dioClient});
  Future<Either<String, List<HistoryPenyewaanResponseModel>>>
      getAllHistory() async {
    final token = await LocalStorage.getToken();
    final response = await dioClient.get(
      "$baseUrl/penyewaan",
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = response.data['data'];
      List<HistoryPenyewaanResponseModel> historyList =
          List<HistoryPenyewaanResponseModel>.from(data.map(
              (history) => HistoryPenyewaanResponseModel.fromJson(history)));
      return Right(historyList);
    } else {
      return const Left("Gagal mengambil data history");
    }
  }

  Future<Either<String, Success>> cancelPenyewaan(
      {required int penyewaanId}) async {
    String token = await LocalStorage.getToken();
    try {
      final response = await dioClient.post(
        "$baseUrl/penyewaan/cancel",
        data: {
          'penyewaan_id': penyewaanId,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            "Authorization": "Bearer $token"
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return Right(Success(message: data['message']));
      }
      throw Exception();
    } on DioError catch (e) {
      final exception = DioException.fromDioError(dioError: e);
      return Left(exception.failure.message);
    }
  }
}
