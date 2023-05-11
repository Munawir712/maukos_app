import 'package:flutter/material.dart';
import 'package:maukos_app/app/domain/entities/kos/kos_entity.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/pesentation/home/components/card_kos.dart';
import 'package:unicons/unicons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* App bar
            Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
                left: defaultMargin,
                right: defaultMargin,
                bottom: 16,
              ),
              color: primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mau Kos",
                        style: textStyle.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Temukan kos terbaik",
                        style: textStyle.copyWith(
                            color: const Color(0xFFDBDBDB), fontSize: 12),
                      ),
                    ],
                  ),
                  Container(
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: secondColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          UniconsLine.bell,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultMargin, bottom: 10),
              child: Text("Di sekitarmu",
                  style: textStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 201,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listKos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? defaultMargin : 0, right: 16),
                      child: InkWell(
                        onTap: () {
                          // KosEntity kos = listKos[index];
                        },
                        child: CardKos(
                          kosEntity: listKos[index],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ));
  }

  Column kategoriItem({required Icon icon, required String label}) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(bottom: 5),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          child: icon,
        ),
        Text(
          label,
          style: textStyle.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
