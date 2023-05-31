import 'package:dio/dio.dart';

import 'response_handling/failure.dart';

class DioException implements Exception {
  late Failure failure;
  DioException.fromDioError(
      {required DioError dioError,
      bool? isRegisterError = false,
      bool? isForgetPassword}) {
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        failure = Failure(
            status: dioError.response!.statusCode ?? 408,
            message: 'Connection Timeout.\nsilahkan coba lagi.');
        break;

      case DioErrorType.sendTimeout:
        failure = Failure(
            status: dioError.response!.statusCode ?? 408,
            message: 'Request send timeout.');
        break;
      case DioErrorType.receiveTimeout:
        failure = Failure(
            status: dioError.response!.statusCode ?? 0,
            message: 'Receiving timeout occurred.\nSilahkan coba lagi.');
        break;
      case DioErrorType.response:
        failure = Failure(
            status: dioError.response!.statusCode ?? 0,
            message: _handleStatusCode(
                dioError: dioError,
                isRegisterError: isRegisterError ?? false,
                isForgetPassword: isForgetPassword ?? false));
        break;
      case DioErrorType.cancel:
        // TODO: Handle this case.
        failure = Failure(
            status: dioError.response!.statusCode ?? 0,
            message:
                'Request to the server was cancelled.\nsilahkan coba lagi.');
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          failure = Failure(
              status: dioError.response!.statusCode ?? 0,
              message: 'No Internet.\nSilahkan coba lagi.');
          break;
        }
        failure = Failure(
            status: dioError.response!.statusCode ?? 0,
            message: 'Unexpected error occurred.\nsilahkan coba lagi.');
        break;
      default:
        failure = Failure(
            status: dioError.response!.statusCode ?? 0,
            message: 'Something went wrong.\nSilahkan coba lagi.');
    }
  }

  String _handleStatusCode(
      {required DioError dioError,
      required bool isRegisterError,
      required bool isForgetPassword}) {
    switch (dioError.response!.statusCode) {
      case 400:
        return 'Bad request.\nSilahkan coba lagi.';
      case 401:
        return 'Authentication failed.\nSilahkan coba lagi.';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.\nSilahkan coba lagi.';
      case 404:
        return 'The requested resource does not exist.\nSilahkan coba lagi.';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.\nSilahkan coba lagi';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.\nSilahkan coba lagi';
      case 422:
        return isRegisterError
            ? _handleStatusCodeRegister(dioError)
            : 'Data validation failed. \nSilahkan coba lagi.';
      case 429:
        return 'Too many requests.\nSilahkan coba lagi.';
      case 500:
        return 'Internal server error.\nSilahkan coba lagi.';
      default:
        return 'Oops something went wrong! \nSilahkan coba lagi';
    }
  }

  String _handleStatusCodeRegister(DioError dioError) {
    String errorMessage = dioError.response!.data.toString();
    var errorEmail = dioError.response!.data['errors']['email'] ?? [];
    var errorName = dioError.response!.data['errors']['name'] ?? [];
    var errorPass = dioError.response!.data['errors']['password'] ?? [];
    var errorPhone = dioError.response!.data['errors']['phone_number'] ?? [];
    var errorJenisKelamin =
        dioError.response!.data['errors']['jenis_kelamin'] ?? [];

    if (errorEmail.isNotEmpty && errorPhone.isNotEmpty) {
      errorMessage = "Email Sudah Terdaftar dan No Telepon Sudah Digunakan ";
    } else if (errorEmail.isNotEmpty) {
      errorMessage = errorEmail[0];
    } else if (errorPhone.isNotEmpty) {
      errorMessage = errorPhone[0];
    } else if (errorName.isNotEmpty) {
      errorMessage = errorName[0];
    } else if (errorPass.isNotEmpty) {
      errorMessage = errorPass[0];
    } else if (errorJenisKelamin.isNotEmpty) {
      errorMessage = errorJenisKelamin[0];
    }
    return errorMessage;
  }

  @override
  String toString() => failure.message;
}
