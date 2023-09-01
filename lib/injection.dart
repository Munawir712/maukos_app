import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:maukos_app/app/data/datasources/history_datasource.dart';
import 'package:maukos_app/app/data/datasources/penyewaan_datasource.dart';
import 'package:maukos_app/core/handling/dio_client.dart';
import 'package:maukos_app/pesentation/auth/cubit/auth_cubit.dart';
import 'package:maukos_app/pesentation/history/cubit/history_cubit.dart';
import 'package:maukos_app/pesentation/home/cubit/kos_cubit.dart';
import 'package:maukos_app/pesentation/penyewaan/cubit/penyewaan_cubit.dart';
import 'package:maukos_app/pesentation/search/cubit/search_kos_cubit.dart';
import 'package:maukos_app/routes/app_router.dart';

import 'app/data/datasources/api_datasources.dart';
import 'app/data/datasources/kos_datasource.dart';

final di = GetIt.instance;

void setup() {
  // router
  di.registerLazySingleton<AppRouter>(() => AppRouter());

  // client
  di.registerLazySingleton(() => Dio());
  di.registerLazySingleton(() => DioClient(di.get()));

  // datasource
  di.registerLazySingleton<ApiDataSources>(() => ApiDataSources());
  di.registerLazySingleton<KosDataSource>(() => KosDataSource());
  di.registerLazySingleton<HistoryDataSource>(() => HistoryDataSource());
  di.registerLazySingleton<PenyewaanDataSource>(() => PenyewaanDataSource());

  // cubit / bloc
  di.registerLazySingleton<AuthCubit>(
      () => AuthCubit(apiDataSources: di.get()));
  di.registerLazySingleton<KosCubit>(() => KosCubit(di.get()));
  di.registerLazySingleton<HistoryCubit>(() => HistoryCubit(di.get()));
  di.registerLazySingleton<PenyewaanCubit>(() => PenyewaanCubit(di.get()));
  di.registerLazySingleton<SearchKosCubit>(() => SearchKosCubit(di.get()));
}
