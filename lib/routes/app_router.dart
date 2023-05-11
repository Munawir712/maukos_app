import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maukos_app/pesentation/auth/page/login_page.dart';
import 'package:maukos_app/pesentation/auth/page/register_page.dart';
import 'package:maukos_app/pesentation/history/page/history_page.dart';
import 'package:maukos_app/pesentation/home/page/home_page.dart';
import 'package:maukos_app/pesentation/main_page.dart';
import 'package:maukos_app/pesentation/profile/page/profile_page.dart';
import 'package:maukos_app/pesentation/search/page/search_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, initial: true, path: '/login'),
    AutoRoute(page: RegisterPage, path: '/register'),
    AutoRoute(page: MainPage, path: '/main'),
    AutoRoute(page: HomePage, path: '/home'),
    AutoRoute(page: SearchPage, path: '/search'),
    AutoRoute(page: HistoryPage, path: '/history'),
    AutoRoute(page: ProfilePage, path: '/profile'),
  ],
)
class AppRouter extends _$AppRouter {}
