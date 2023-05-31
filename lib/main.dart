import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/injection.dart';
import 'package:maukos_app/pesentation/auth/cubit/auth_cubit.dart';
import 'package:maukos_app/routes/app_router.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<AuthCubit>(create: (context) => di.get()),
        BlocProvider<AuthCubit>(
            create: (context) => di.get()..getCurrentUser()),
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
