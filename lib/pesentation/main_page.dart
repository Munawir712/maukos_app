import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/injection.dart';
import 'package:maukos_app/pesentation/auth/cubit/auth_cubit.dart';
import 'package:maukos_app/pesentation/history/page/history_page.dart';
import 'package:maukos_app/pesentation/home/page/home_page.dart';
import 'package:maukos_app/pesentation/profile/page/profile_page.dart';
import 'package:maukos_app/pesentation/search/page/search_page.dart';
import 'package:maukos_app/routes/app_router.dart';
import 'package:unicons/unicons.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.initialPage = 0});
  final int initialPage;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    const HomePage(),
    SearchPage(),
    // const MyKosPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black38,
        selectedLabelStyle:
            textStyle.copyWith(fontSize: 12, color: Colors.black38),
        unselectedLabelStyle: textStyle.copyWith(fontSize: 12),
        onTap: (index) async {
          if (index == 2 || index == 3) {
            final authState = context.read<AuthCubit>().state;
            // final userToken = await LocalStorage.getToken();
            // if (userToken.isNotEmpty) {
            //   setState(() {
            //     currentIndex = index;
            //   });
            // } else {
            //   di.get<AppRouter>().push(const LoginRoute());
            // }
            if (authState is AuthLoaded) {
              setState(() {
                currentIndex = index;
              });
            } else {
              di.get<AppRouter>().push(const LoginRoute());
            }
          } else {
            setState(() {
              currentIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.home_alt), label: "Beranda"),
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.search), label: "Cari"),
          // BottomNavigationBarItem(
          //     icon: Icon(UniconsLine.home), label: "Kos Saya"),
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.history_alt), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.user), label: "Profile"),
        ],
      ),
    );
  }
}
