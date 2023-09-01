import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maukos_app/app/data/models/kos/facilities_model.dart';
import 'package:maukos_app/app/domain/entities/kos/kos_entity.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/core/widget/custom_box_image.dart';
import 'package:maukos_app/injection.dart';
import 'package:maukos_app/pesentation/auth/cubit/auth_cubit.dart';
import 'package:maukos_app/pesentation/home/components/kos/kos_alert_bottom_sheet.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';

import '../../../../routes/app_router.dart';

class KosDetailPage extends StatefulWidget {
  final KosEntity kosEntity;
  const KosDetailPage({Key? key, required this.kosEntity}) : super(key: key);

  @override
  State<KosDetailPage> createState() => _KosDetailPageState();
}

class _KosDetailPageState extends State<KosDetailPage> {
  int selectedIndex = 0;
  late final PageController pageController;
  final TextEditingController lamaSewaCount = TextEditingController(text: "1");
  int limit = 3;
  bool isReadmore = false;
  bool isShowmore = false;
  DateTime? tglMulaiKos = DateTime.now();

  @override
  void initState() {
    pageController = PageController(initialPage: selectedIndex);
    super.initState();
  }

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body?.text).documentElement!.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: (() => FocusScope.of(context).unfocus()),
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: content(),
              ),
              appBar(),
              Align(
                alignment: Alignment.bottomCenter,
                child: bottomNav(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container appBar() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.circle,
            ),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                )),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.circle,
            ),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    // widget.kosEntity.isBookmark = !widget.kosEntity.isBookmark;
                  });
                },
                icon: const Icon(
                  Icons.bookmark_border,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }

  Widget bottomNav() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (context.read<AuthCubit>().state is AuthLoaded) {
                  final userState =
                      (context.read<AuthCubit>().state as AuthLoaded);
                  final genderUser = userState.user.penyewa.jenisKelamin;
                  final validKosGender = widget.kosEntity.genderCategory;
                  if (genderUser == "pria" && validKosGender == 'PUTRI') {
                    KosBottomSheet.showKosGenderInvalid(context);
                  } else if (genderUser == "wanita" &&
                      validKosGender == 'PUTRA') {
                    KosBottomSheet.showKosGenderInvalid(
                      context,
                      title: 'Kos ini Khusus untuk pria',
                      desc:
                          'Mohon maaf, hanya penyewa pria yang dapat menyewa kos putra.',
                    );
                  } else {
                    KosBottomSheet.showDatePicker(
                      context,
                      initialDate: [DateTime.now()],
                      onConfirm: () {
                        if (tglMulaiKos != null) {
                          di.get<AppRouter>().push(
                                PenyewaanRoute(
                                  kosEntity: widget.kosEntity,
                                  lamaSewa: 1,
                                  tanggalMulaiKos: tglMulaiKos!,
                                ),
                              );
                        }
                      },
                      onValueChanged: (date) {
                        log(date[0].toString());
                        setState(() {
                          tglMulaiKos = date[0];
                        });
                      },
                    );
                  }
                } else {
                  di.get<AppRouter>().push(const LoginRoute());
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  textStyle: textStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w600)),
              child: const Text("Sewa"),
            ),
          ),
        ],
      ),
    );
  }

  Widget content() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageSlider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.kosEntity.name,
                  style: xlMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          widget.kosEntity.genderCategory,
                          style: textStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('-', style: mMedium),
                      const SizedBox(width: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 16,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: deviceWidth(context) - 165,
                            child: Text(
                              widget.kosEntity.address,
                              style: sRegular,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (widget.kosEntity.type == 'KAMAR')
                  Text.rich(
                    TextSpan(
                      text: "Tersisa ",
                      style: mRegular,
                      children: [
                        TextSpan(
                          text:
                              '${widget.kosEntity.amountKos - widget.kosEntity.amountRented} Kamar',
                          style: mBold.copyWith(color: redColor),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                    text: "${numberFormat.format(widget.kosEntity.price)} ",
                    style: xlBold,
                    children: [
                      TextSpan(text: '/ Bulan', style: mRegular),
                    ],
                  ),
                ),
                const Divider(thickness: 3),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fasilitas",
                      style: lSemibold,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isShowmore = !isShowmore;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            "Selengkapnya",
                            style: textStyle.copyWith(
                                fontSize: 12,
                                color: secondColor,
                                fontWeight: FontWeight.w400),
                          ),
                          Icon(
                            isShowmore
                                ? Icons.arrow_drop_up_rounded
                                : Icons.arrow_drop_down,
                            color: secondColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                listFasilitas(), //
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Deskirpsi",
                  style: lSemibold,
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _parseHtmlString(widget.kosEntity.description),
                      // widget.kosEntity.description,
                      textAlign: TextAlign.justify,
                      style: textStyle.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w400),
                      maxLines: isReadmore ? null : 3,
                      overflow: isReadmore
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isReadmore = !isReadmore;
                        });
                      },
                      child: Text(
                        isReadmore ? "Lebih sedikit" : "Lebih banyak",
                        style: textStyle.copyWith(
                            fontSize: 12,
                            color: secondColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton.icon(
                          icon: Image.asset(
                            '$assetImage/wa.png',
                            width: 40,
                            height: 40,
                          ),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 8,
                            ),
                          ),
                          onPressed: () {
                            launchWhatApp('0811682985', widget.kosEntity);
                          },
                          label: Text(
                            'Hubungin Pemilik',
                            style: mMedium.copyWith(color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: TextButton.icon(
                          icon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              '$assetImage/gmap.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            _launchGoogleMaps(
                              widget.kosEntity.latitude,
                              widget.kosEntity.longitude,
                            );
                          },
                          label: Text(
                            'Lokasi',
                            style: mMedium.copyWith(color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listFasilitas() {
    if (isShowmore) {
      return Wrap(
        spacing: 3,
        runSpacing: 4,
        children: widget.kosEntity.facilities.map((e) {
          return FasilitasBoxWidget(
            fasilitas: e,
          );
        }).toList(),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.kosEntity.facilities.map((e) {
            return Padding(
              padding: const EdgeInsets.only(right: 3),
              child: FasilitasBoxWidget(fasilitas: e),
            );
          }).toList(),
        ),
      );
    }
  }

  Widget imageSlider() {
    String baseUrl = dotenv.get('URL');
    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            // children: const [],
            children: widget.kosEntity.imagesPaths
                .map(
                  (url) => CustomBoxImage(
                    imageUrl: "$baseUrl/$url",
                    isNetwork: true,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
          ),
          // * Dot
          Positioned(
            bottom: 10,
            child: SizedBox(
              child: Row(
                children: List.generate(
                  widget.kosEntity.imagesPaths.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          index == selectedIndex ? primaryColor : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchGoogleMaps(String latitude, String longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      log('Tidak dapat launch Google Maps');
    }
  }
}

class FasilitasBoxWidget extends StatelessWidget {
  final FacilityModel fasilitas;
  final double iconSize;
  final Color iconColor;

  const FasilitasBoxWidget({
    Key? key,
    required this.fasilitas,
    this.iconSize = 18,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        // color: primaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          getIconData(fasilitas.slug),
          const SizedBox(
            width: 5,
          ),
          Text(
            fasilitas.name,
            style: textStyle.copyWith(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget getIconData(String slug) {
    switch (slug) {
      case 'single_bed':
        return Icon(
          Icons.bedroom_child,
          size: iconSize,
          color: iconColor,
        );
      case 'double_bed':
        return Icon(
          Icons.bed,
          size: iconSize,
          color: iconColor,
        );
      case 'tv':
        return Icon(
          Icons.tv_rounded,
          size: iconSize,
          color: iconColor,
        );
      case 'meja':
        return Icon(
          Icons.table_restaurant_rounded,
          size: iconSize,
          color: iconColor,
        );
      case 'wifi':
        return Icon(
          Icons.wifi,
          size: iconSize,
          color: iconColor,
        );
      case 'kursi':
        return Icon(
          Icons.chair_rounded,
          size: iconSize,
          color: iconColor,
        );
      case 'ac':
        return Icon(
          Icons.ac_unit,
          size: iconSize,
          color: iconColor,
        );
      case 'kamar_mandi':
        return Icon(
          UniconsLine.bath,
          size: iconSize,
          color: iconColor,
        );
      case 'lemari':
        return Icon(
          UniconsLine.server_alt,
          size: iconSize,
          color: iconColor,
        );
      case 'kipas_angin':
        return Icon(
          Icons.air_rounded,
          size: iconSize,
          color: iconColor,
        );
      case 'air_gratis':
        return Icon(
          Icons.water_drop_outlined,
          size: iconSize,
          color: iconColor,
        );
      default:
        return const SizedBox();
    }
  }
}
