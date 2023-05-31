import 'package:flutter/material.dart';
import 'package:maukos_app/pesentation/history/page/history_page.dart';
import 'package:maukos_app/pesentation/home/page/home_page.dart';
import 'package:maukos_app/pesentation/profile/page/profile_page.dart';
import 'package:maukos_app/pesentation/search/page/search_page.dart';
import 'package:maukos_app/pesentation/mykos/page/mykos_page.dart';
import 'package:unicons/unicons.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    MyKosPage(),
    HistoryPage(),
    ProfilePage(),
  ];

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
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.home_alt), label: "Beranda"),
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.search), label: "Cari"),
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.home), label: "Kos Saya"),
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.history_alt), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(UniconsLine.user), label: "Profile"),
        ],
      ),
    );
  }
}
