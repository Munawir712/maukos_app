import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maukos_app/injection.dart';
import 'package:maukos_app/pesentation/auth/cubit/auth_cubit.dart';
import 'package:maukos_app/pesentation/history/cubit/history_cubit.dart';
import 'package:maukos_app/pesentation/home/cubit/kos_cubit.dart';
import 'package:maukos_app/pesentation/penyewaan/cubit/penyewaan_cubit.dart';
import 'package:maukos_app/pesentation/search/cubit/search_kos_cubit.dart';
import 'package:maukos_app/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await dotenv.load(fileName: ".env.dev");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (context) => di.get()..getCurrentUser()),
        BlocProvider<KosCubit>(create: (context) => di.get()),
        BlocProvider<HistoryCubit>(create: (context) => di.get()),
        BlocProvider<PenyewaanCubit>(create: (context) => di.get()),
        BlocProvider<SearchKosCubit>(create: (context) => di.get()),
      ],
      child: MaterialApp.router(
        title: 'Mau Kos',
        debugShowCheckedModeBanner: false,
        routerDelegate: di.get<AppRouter>().delegate(),
        routeInformationParser: di.get<AppRouter>().defaultRouteParser(),
        routeInformationProvider: di.get<AppRouter>().routeInfoProvider(),
      ),
    );
  }
}
