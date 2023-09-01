// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const RegisterPage(),
      );
    },
    MainRoute.name: (routeData) {
      final args =
          routeData.argsAs<MainRouteArgs>(orElse: () => const MainRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: MainPage(
          key: args.key,
          initialPage: args.initialPage,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    SearchRoute.name: (routeData) {
      final args = routeData.argsAs<SearchRouteArgs>(
          orElse: () => const SearchRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: SearchPage(key: args.key),
      );
    },
    HistoryRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HistoryPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    KosDetailRoute.name: (routeData) {
      final args = routeData.argsAs<KosDetailRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: KosDetailPage(
          key: args.key,
          kosEntity: args.kosEntity,
        ),
      );
    },
    PenyewaanRoute.name: (routeData) {
      final args = routeData.argsAs<PenyewaanRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PenyewaanPage(
          key: args.key,
          kosEntity: args.kosEntity,
          lamaSewa: args.lamaSewa,
          tanggalMulaiKos: args.tanggalMulaiKos,
        ),
      );
    },
    AdminWrapperRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AdminWrapperPage(),
      );
    },
    HomeAdminRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeAdminPage(),
      );
    },
    ProfileAdminRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ProfileAdminPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash',
          fullMatch: true,
        ),
        RouteConfig(
          SplashRoute.name,
          path: '/splash',
        ),
        RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
        RouteConfig(
          MainRoute.name,
          path: '/main',
        ),
        RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        RouteConfig(
          SearchRoute.name,
          path: '/search',
        ),
        RouteConfig(
          HistoryRoute.name,
          path: '/history',
        ),
        RouteConfig(
          ProfileRoute.name,
          path: '/profile',
        ),
        RouteConfig(
          KosDetailRoute.name,
          path: '/kos_detail',
        ),
        RouteConfig(
          PenyewaanRoute.name,
          path: '/checkout',
        ),
        RouteConfig(
          AdminWrapperRoute.name,
          path: '/admin',
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: AdminWrapperRoute.name,
              redirectTo: 'home_admin',
              fullMatch: true,
            ),
            RouteConfig(
              HomeAdminRoute.name,
              path: 'home_admin',
              parent: AdminWrapperRoute.name,
            ),
            RouteConfig(
              ProfileAdminRoute.name,
              path: 'profile_admin',
              parent: AdminWrapperRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<MainRouteArgs> {
  MainRoute({
    Key? key,
    int initialPage = 0,
  }) : super(
          MainRoute.name,
          path: '/main',
          args: MainRouteArgs(
            key: key,
            initialPage: initialPage,
          ),
        );

  static const String name = 'MainRoute';
}

class MainRouteArgs {
  const MainRouteArgs({
    this.key,
    this.initialPage = 0,
  });

  final Key? key;

  final int initialPage;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key, initialPage: $initialPage}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<SearchRouteArgs> {
  SearchRoute({Key? key})
      : super(
          SearchRoute.name,
          path: '/search',
          args: SearchRouteArgs(key: key),
        );

  static const String name = 'SearchRoute';
}

class SearchRouteArgs {
  const SearchRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key}';
  }
}

/// generated route for
/// [HistoryPage]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute()
      : super(
          HistoryRoute.name,
          path: '/history',
        );

  static const String name = 'HistoryRoute';
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: '/profile',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [KosDetailPage]
class KosDetailRoute extends PageRouteInfo<KosDetailRouteArgs> {
  KosDetailRoute({
    Key? key,
    required KosEntity kosEntity,
  }) : super(
          KosDetailRoute.name,
          path: '/kos_detail',
          args: KosDetailRouteArgs(
            key: key,
            kosEntity: kosEntity,
          ),
        );

  static const String name = 'KosDetailRoute';
}

class KosDetailRouteArgs {
  const KosDetailRouteArgs({
    this.key,
    required this.kosEntity,
  });

  final Key? key;

  final KosEntity kosEntity;

  @override
  String toString() {
    return 'KosDetailRouteArgs{key: $key, kosEntity: $kosEntity}';
  }
}

/// generated route for
/// [PenyewaanPage]
class PenyewaanRoute extends PageRouteInfo<PenyewaanRouteArgs> {
  PenyewaanRoute({
    Key? key,
    required KosEntity kosEntity,
    required int lamaSewa,
    required DateTime tanggalMulaiKos,
  }) : super(
          PenyewaanRoute.name,
          path: '/checkout',
          args: PenyewaanRouteArgs(
            key: key,
            kosEntity: kosEntity,
            lamaSewa: lamaSewa,
            tanggalMulaiKos: tanggalMulaiKos,
          ),
        );

  static const String name = 'PenyewaanRoute';
}

class PenyewaanRouteArgs {
  const PenyewaanRouteArgs({
    this.key,
    required this.kosEntity,
    required this.lamaSewa,
    required this.tanggalMulaiKos,
  });

  final Key? key;

  final KosEntity kosEntity;

  final int lamaSewa;

  final DateTime tanggalMulaiKos;

  @override
  String toString() {
    return 'PenyewaanRouteArgs{key: $key, kosEntity: $kosEntity, lamaSewa: $lamaSewa, tanggalMulaiKos: $tanggalMulaiKos}';
  }
}

/// generated route for
/// [AdminWrapperPage]
class AdminWrapperRoute extends PageRouteInfo<void> {
  const AdminWrapperRoute({List<PageRouteInfo>? children})
      : super(
          AdminWrapperRoute.name,
          path: '/admin',
          initialChildren: children,
        );

  static const String name = 'AdminWrapperRoute';
}

/// generated route for
/// [HomeAdminPage]
class HomeAdminRoute extends PageRouteInfo<void> {
  const HomeAdminRoute()
      : super(
          HomeAdminRoute.name,
          path: 'home_admin',
        );

  static const String name = 'HomeAdminRoute';
}

/// generated route for
/// [ProfileAdminPage]
class ProfileAdminRoute extends PageRouteInfo<void> {
  const ProfileAdminRoute()
      : super(
          ProfileAdminRoute.name,
          path: 'profile_admin',
        );

  static const String name = 'ProfileAdminRoute';
}
