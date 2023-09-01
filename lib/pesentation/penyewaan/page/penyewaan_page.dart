import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:maukos_app/app/domain/entities/kos/kos_entity.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/core/widget/custom_flushbar_message.dart';
import 'package:maukos_app/injection.dart';
import 'package:maukos_app/pesentation/auth/cubit/auth_cubit.dart';
import 'package:maukos_app/routes/app_router.dart';

import '../../../app/data/models/penyewaan/penyewaan_request_model.dart';
import '../../../core/widget/custom_box_image.dart';
import '../cubit/penyewaan_cubit.dart';

class PenyewaanPage extends StatefulWidget {
  final KosEntity kosEntity;
  final int lamaSewa;
  final DateTime tanggalMulaiKos;
  const PenyewaanPage(
      {Key? key,
      required this.kosEntity,
      required this.lamaSewa,
      required this.tanggalMulaiKos})
      : super(key: key);

  @override
  State<PenyewaanPage> createState() => _PenyewaanPageState();
}

class _PenyewaanPageState extends State<PenyewaanPage> {
  late int lamaSewa;
  int jumlahPenyewa = 1;

  @override
  void initState() {
    lamaSewa = widget.lamaSewa;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.read<AuthCubit>().state;
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Sewa",
          style: textStyle.copyWith(
              fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Total Bayar",
                  style:
                      textStyle.copyWith(fontSize: 12, color: Colors.black45),
                ),
                Text(
                  numberFormat.format(widget.kosEntity.price * lamaSewa),
                  style: textStyle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 40,
              width: 130,
              child: BlocConsumer<PenyewaanCubit, PenyewaanState>(
                listener: (context, state) {
                  if (state is PenyewaanSuccess) {
                    CustomFlushBarMessage.message(
                      title: 'Success',
                      message: state.message,
                      position: FlushbarPosition.TOP,
                    ).show(context);
                    Future.delayed(const Duration(seconds: 2), () async {
                      log("push ke history");
                      di.get<AppRouter>().replace(MainRoute(initialPage: 2));
                    });
                  }
                  if (state is PenyewaanError) {
                    CustomFlushBarMessage.message(
                      title: 'Peringatan',
                      isFailed: true,
                      message: state.message,
                      position: FlushbarPosition.TOP,
                    ).show(context);
                  }
                },
                builder: (context, state) {
                  if (state is PenyewaanLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      context.read<PenyewaanCubit>().sewa(
                            PenyewaanRequestModel(
                              kosanId: widget.kosEntity.kosId,
                              tanggalMulai: widget.tanggalMulaiKos.toString(),
                              durasiSewa: lamaSewa,
                              total: widget.kosEntity.price * lamaSewa,
                              jumlahOrang: jumlahPenyewa,
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      textStyle:
                          textStyle.copyWith(fontWeight: FontWeight.w600),
                    ),
                    child: const Text("Sewa"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            itemSection(),
            const SizedBox(height: 10),
            informasiPenyewaSection(userState),
            const SizedBox(height: 10),
            jumlahPenyewaSection(userState),
            const SizedBox(height: 10),
            durasiPenyewaanSection(),
            const SizedBox(height: 10),
            tanggalMulaiNgekos(),
            const SizedBox(height: 10),
            pembayaranSection(),
            detailSection(userState),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Container informasiPenyewaSection(AuthState userState) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Informasi penyewa",
            style: lSemibold,
          ),
          if (userState is AuthLoaded)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Nama penyewa",
                style: mMedium,
              ),
              subtitle: Text(userState.user.name!.capitalize()),
            ),
          if (userState is AuthLoaded)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Nomor HP",
                style: mMedium,
              ),
              subtitle: Text(
                userState.user.penyewa.phoneNumber,
                style: mRegular,
              ),
            ),
          if (userState is AuthLoaded)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Jenis kelamin",
                style: mMedium,
              ),
              subtitle: Text(
                userState.user.penyewa.jenisKelamin.capitalize(),
                style: mRegular,
              ),
            ),
        ],
      ),
    );
  }

  Container jumlahPenyewaSection(AuthState userState) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jumlah penyewa",
            style: lSemibold,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (jumlahPenyewa > 1) {
                        jumlahPenyewa--;
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline_rounded,
                    color: secondColor,
                  )),
              Text(
                "$jumlahPenyewa Orang",
                style: mSemibold,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (jumlahPenyewa < widget.kosEntity.maxPeople) {
                        jumlahPenyewa++;
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                    color: secondColor,
                  )),
            ],
          ),
          Text(
            "Maksimal ${widget.kosEntity.maxPeople} penyewa",
            style: textStyle.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Container durasiPenyewaanSection() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Durasi ngekos",
            style: lSemibold,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (lamaSewa > 1) {
                        lamaSewa--;
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline_rounded,
                    color: secondColor,
                  )),
              Text(
                "$lamaSewa Bulan",
                style: mSemibold,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (lamaSewa < 12) {
                        lamaSewa++;
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                    color: secondColor,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Container tanggalMulaiNgekos() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tanggal mulai ngekos",
            style: lSemibold,
          ),
          Text(
            DateFormat('d MMM y').format(widget.tanggalMulaiKos),
            style: mRegular,
          ),
        ],
      ),
    );
  }

  Container itemSection() {
    String baseUrl = dotenv.get('URL');
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.kosEntity.imagesPaths.isNotEmpty) ...[
                CustomBoxImage(
                  imageUrl: "$baseUrl/${widget.kosEntity.imagesPaths[0]}",
                  width: 70,
                  height: 70,
                  isNetwork: true,
                  borderRadius: BorderRadius.circular(8),
                  fit: BoxFit.cover,
                ),
              ] else ...[
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey.shade700,
                  ),
                )
              ],
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.kosEntity.genderCategory,
                      style: sBold.copyWith(color: whiteColor),
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth(context) - (2 * 16) - 138,
                    child: Text(
                      widget.kosEntity.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: mSemibold,
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth(context) - (2 * 16) - 138,
                    child: Text(
                      widget.kosEntity.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: mSemibold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container pembayaranSection() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rincihan pembayaran",
            style: lSemibold,
          ),
          // const SizedBox(
          //   height: 12,
          // ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: const Color(0xFFE5E5E5)),
          //     borderRadius: BorderRadius.circular(4),
          //   ),
          //   child: Row(
          //     children: [
          //       const Icon(
          //         Icons.description,
          //         color: Colors.black54,
          //       ),
          //       const SizedBox(
          //         width: 5,
          //       ),
          //       Text(
          //         "Metode pembayaran",
          //         style: textStyle.copyWith(
          //             color: Colors.black54, fontWeight: FontWeight.w600),
          //       ),
          //       const Spacer(),
          //       const Icon(
          //         Icons.arrow_forward_ios_rounded,
          //         size: 16,
          //         color: Colors.black54,
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Container detailSection(AuthState userState) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nama penyewa",
                style: textStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (userState is AuthLoaded)
                Text(
                  userState.user.name!.capitalize(),
                  style: textStyle.copyWith(
                      fontWeight: FontWeight.w400, color: Colors.black54),
                ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Harga per bulan",
                style: textStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                numberFormat.format(widget.kosEntity.price),
                style: textStyle.copyWith(
                    fontWeight: FontWeight.w400, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Lama sewa",
                style: textStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "$lamaSewa Bulan",
                style: textStyle.copyWith(
                    fontWeight: FontWeight.w400, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: textStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                numberFormat.format(widget.kosEntity.price * lamaSewa),
                style: textStyle.copyWith(
                    fontWeight: FontWeight.w400, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
