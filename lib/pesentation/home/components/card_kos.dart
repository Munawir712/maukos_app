import 'package:flutter/material.dart';
import 'package:maukos_app/app/domain/entities/kos/kos_entity.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';

class CardKos extends StatelessWidget {
  final KosEntity kosEntity;
  final double width;
  final double? height;

  const CardKos({
    Key? key,
    required this.kosEntity,
    this.width = 200,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFF3F3F3),
              offset: Offset(0, 6),
              blurRadius: 16,
            )
          ]),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFDEDEDE),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                image: DecorationImage(
                  image: NetworkImage(kosEntity.imagesPaths[0]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 10,
                    bottom: -12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        kosEntity.genderCategory,
                        style: textStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 5,
                      top: 5,
                      child: StatefulBuilder(builder: (context, setState) {
                        return IconButton(
                            onPressed: () {
                              // setState(
                              //   () {
                              //     kosEntity.isBookmark = !kosEntity.isBookmark;
                              //   },
                              // );
                            },
                            icon: Icon(
                              false ? Icons.bookmark : Icons.bookmark_outline,
                              color: Colors.white,
                            ));
                      })),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 6,
              right: 6,
              top: 12,
              // bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kosEntity.name,
                  style: textStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  kosEntity.address,
                  style: textStyle.copyWith(
                      fontSize: 12, color: const Color(0xFF555555)),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      kosEntity.type,
                      style: textStyle.copyWith(fontWeight: FontWeight.w400),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          numberFormat.format(kosEntity.price),
                          style: textStyle.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Bulan',
                          style: textStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
