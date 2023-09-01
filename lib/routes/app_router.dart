import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maukos_app/persentation_admin/admin_wrapper_page.dart';
import 'package:maukos_app/persentation_admin/home_admin/page/home_admin_page.dart';
import 'package:maukos_app/persentation_admin/profile_admin/page/profile_admin_page.dart';
import 'package:maukos_app/pesentation/auth/page/login_page.dart';
import 'package:maukos_app/pesentation/auth/page/register_page.dart';
import 'package:maukos_app/pesentation/history/page/history_page.dart';
import 'package:maukos_app/pesentation/home/components/kos/kos_detail_page.dart';
import 'package:maukos_app/pesentation/home/page/home_page.dart';
import 'package:maukos_app/pesentation/main_page.dart';
import 'package:maukos_app/pesentation/penyewaan/page/penyewaan_page.dart';
import 'package:maukos_app/pesentation/profile/page/profile_page.dart';
import 'package:maukos_app/pesentation/search/page/search_page.dart';
import 'package:maukos_app/pesentation/splash/page/splash_page.dart';

import '../app/domain/entities/kos/kos_entity.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true, path: '/splash'),
    AutoRoute(page: LoginPage, path: '/login'),
    AutoRoute(page: RegisterPage, path: '/register'),
    AutoRoute(page: MainPage, path: '/main'),
    AutoRoute(page: HomePage, path: '/home'),
    AutoRoute(page: SearchPage, path: '/search'),
    AutoRoute(page: HistoryPage, path: '/history'),
    AutoRoute(page: ProfilePage, path: '/profile'),
    AutoRoute(page: KosDetailPage, path: '/kos_detail'),
    AutoRoute(page: PenyewaanPage, path: '/checkout'),
    AutoRoute(
      page: AdminWrapperPage,
      path: '/admin',
      children: [
        AutoRoute(
          page: HomeAdminPage,
          path: 'home_admin',
          initial: true,
        ),
        AutoRoute(
          page: ProfileAdminPage,
          path: 'profile_admin',
        ),
      ],
    ),
  ],
)
class AppRouter extends _$AppRouter {}
