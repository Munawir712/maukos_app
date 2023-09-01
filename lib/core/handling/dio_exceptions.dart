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
            status: 408, message: 'Connection Timeout.\nsilahkan coba lagi.');
        break;

      case DioErrorType.sendTimeout:
        failure = Failure(status: 408, message: 'Request send timeout.');
        break;
      case DioErrorType.receiveTimeout:
        failure = Failure(
            status: 0,
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
            status: 0,
            message:
                'Request to the server was cancelled.\nsilahkan coba lagi.');
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          failure =
              Failure(status: 0, message: 'No Internet.\nSilahkan coba lagi.');
          break;
        }
        failure = Failure(
            status: 0,
            message: 'Unexpected error occurred.\nsilahkan coba lagi.');
        break;
      default:
        failure = Failure(
            status: 0, message: 'Something went wrong.\nSilahkan coba lagi.');
    }
  }

  String _handleStatusCode(
      {required DioError dioError,
      required bool isRegisterError,
      required bool isForgetPassword}) {
    var errorMessage = dioError.response!.data;
    switch (dioError.response!.statusCode) {
      case 400:
        return errorMessage['message'] ?? 'Bad request.\nSilahkan coba lagi.';
      case 401:
        return errorMessage['message'] ??
            'Authentication failed.\nSilahkan coba lagi.';
      case 403:
        return errorMessage['message'] ??
            'The authenticated user is not allowed to access the specified API endpoint.\nSilahkan coba lagi.';
      case 404:
        return errorMessage['message'] ??
            'The requested resource does not exist.\nSilahkan coba lagi.';
      case 405:
        return errorMessage['message'] ??
            'Method not allowed. Please check the Allow header for the allowed HTTP methods.\nSilahkan coba lagi';
      case 415:
        return errorMessage['message'] ??
            'Unsupported media type. The requested content type or version number is invalid.\nSilahkan coba lagi';
      case 422:
        return isRegisterError
            ? _handleStatusCodeRegister(dioError)
            : errorMessage['message'] ??
                'Data validation failed. \nSilahkan coba lagi.';
      case 429:
        return errorMessage['message'] ??
            'Too many requests.\nSilahkan coba lagi.';
      case 500:
        return 'Internal server error.\nSilahkan coba lagi.';
      default:
        return errorMessage['message'] ??
            'Oops something went wrong! \nSilahkan coba lagi';
    }
  }

  String _handleStatusCodeRegister(DioError dioError) {
    String errorMessage = dioError.response!.data.toString();
    var username = dioError.response!.data['errors']['username'] ?? [];
    var errorName = dioError.response!.data['errors']['name'] ?? [];
    var errorPass = dioError.response!.data['errors']['password'] ?? [];
    var errorPhone = dioError.response!.data['errors']['phone_number'] ?? [];
    var errorJenisKelamin =
        dioError.response!.data['errors']['jenis_kelamin'] ?? [];

    if (username.isNotEmpty && errorPhone.isNotEmpty) {
      errorMessage = "Username Sudah Terdaftar";
      errorMessage = "${username[0]} dan ${errorPhone[0]}";
    } else if (username.isNotEmpty) {
      errorMessage = username[0];
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
