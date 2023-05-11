import 'package:get_it/get_it.dart';
import 'package:maukos_app/routes/app_router.dart';

final di = GetIt.instance;

void setup() {
  di.registerLazySingleton<AppRouter>(() => AppRouter());
}
