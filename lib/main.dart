import 'package:flutter/material.dart';
import 'package:maukos_app/injection.dart';
import 'package:maukos_app/routes/app_router.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mau Kos',
      debugShowCheckedModeBanner: false,
      routerDelegate: di.get<AppRouter>().delegate(),
      routeInformationParser: di.get<AppRouter>().defaultRouteParser(),
      routeInformationProvider: di.get<AppRouter>().routeInfoProvider(),
    );
  }
}
