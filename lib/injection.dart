import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:maukos_app/app/data/datasources/api_datasources.dart';
import 'package:maukos_app/core/handling/dio_client.dart';
import 'package:maukos_app/pesentation/auth/cubit/auth_cubit.dart';
import 'package:maukos_app/routes/app_router.dart';

final di = GetIt.instance;

void setup() {
  di.registerLazySingleton<AppRouter>(() => AppRouter());

  di.registerLazySingleton(() => Dio());
  di.registerLazySingleton(() => DioClient(di.get()));
  di.registerLazySingleton<ApiDataSources>(
      () => ApiDataSources(dioClient: di.get()));
  di.registerLazySingleton<AuthCubit>(
      () => AuthCubit(apiDataSources: di.get()));
}
