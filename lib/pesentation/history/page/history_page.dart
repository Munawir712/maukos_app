import 'package:flutter/material.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List tabs = ['Berlangsung', 'Belum dikonfirmasi', 'Dikonfirmasi'];
  late int selectedIndex;
  bool hasSewa = true;

  @override
  void initState() {
    super.initState();
    selectedIndex = hasSewa ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Riwayat Sewa',
          style: textStyle.copyWith(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            customTabBar(),
            const Divider(),
            Builder(builder: (context) {
              if (selectedIndex == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: HistoryListItem(
                    img:
                        "https://images.unsplash.com/photo-1572120360610-d971b9d7767c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
                    name: "Kos Campuran",
                  ),
                );
              } else if (selectedIndex == 1) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: HistoryListItem(
                    img:
                        "https://images.unsplash.com/photo-1516156008625-3a9d6067fab5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NjF8fGhvdXNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                    name: "Kos Purtri",
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: HistoryListItem(
                    img:
                        "https://images.unsplash.com/photo-1516156008625-3a9d6067fab5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NjF8fGhvdXNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                    name: "Kos Purtra",
                  ),
                );
              }
            }),
            // HistoryListItem(),
          ],
        ),
      ),
    );
  }

  Widget customTabBar() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          if (!hasSewa && index == 0) {
            return SizedBox();
          } else {
            return Container(
              margin: EdgeInsets.only(
                left: 12,
                right: tabs.length - 1 == index ? 12 : 0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedIndex == index ? primaryColor : null,
                border: selectedIndex == index
                    ? null
                    : Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(20),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Text(
                  tabs[index],
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color:
                        index == selectedIndex ? Colors.white : Colors.black38,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class HistoryListItem extends StatelessWidget {
  final String img;
  final String name;
  const HistoryListItem({
    Key? key,
    required this.img,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: const Color(0xFFDEDEDE),
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage(img), fit: BoxFit.cover)),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - (2 * 16) - 60 - 10 - 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${numberFormat.format(1000000)} - per 2 bulan",
                  style: textStyle.copyWith(
                      fontSize: 13,
                      color: Colors.black38,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            width: 110,
            alignment: Alignment.centerRight,
            child: Text(
              "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
              style: textStyle.copyWith(
                  fontSize: 12,
                  color: Colors.black38,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
