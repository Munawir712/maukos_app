import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:maukos_app/app/data/models/history/history_penyewaan_response_model.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/core/widget/button_widget.dart';
import 'package:maukos_app/core/widget/custom_flushbar_message.dart';
import 'package:maukos_app/injection.dart';
import 'package:maukos_app/pesentation/history/cubit/history_cubit.dart';
import 'package:maukos_app/routes/app_router.dart';

import '../../../core/widget/custom_box_image.dart';
import 'fasilitas_kosan.dart';

class HistoryDetailPage extends StatelessWidget {
  const HistoryDetailPage({super.key, required this.history});
  final HistoryPenyewaanResponseModel history;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "Detail Penyewaan",
          style: lSemibold,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        child: history.status == HistoryStatus.belumDikonfirmasi
            ? BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
                return ButtonWidget(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 12),
                            title: Text(
                              'Peringatan',
                              style: textStyle,
                            ),
                            content: Text(
                              "Untuk membatalakan penyewaan ini?",
                              style: textStyle.copyWith(color: Colors.black54),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor),
                                child: const Text("No"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  context
                                      .read<HistoryCubit>()
                                      .cancelPenyewaan(history.id);
                                  if (state is HistoryLoaded) {
                                    Navigator.pop(context);
                                    CustomFlushBarMessage.message(
                                      title: 'Sukses',
                                      message: "Penyewaan Dibatalkan",
                                    ).show(context);
                                  }
                                  if (state is HistoryError) {
                                    CustomFlushBarMessage.message(
                                        title: 'Peringatan',
                                        message: state.message);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: BorderSide(
                                        color: Colors.red.shade400,
                                        width: 2,
                                      )),
                                  backgroundColor: Colors.white,
                                ),
                                child: Text(
                                  "Yes",
                                  style: textStyle.copyWith(
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  },
                  height: 50,
                  backgroundColor: Colors.grey.shade500,
                  labelStyle: textStyle.copyWith(),
                  label: "Batalkan Sewa",
                );
              })
            : history.status == HistoryStatus.dikonfirmasi
                ? ButtonWidget(
                    height: 50,
                    onPressed: () {
                      launchWhatApp('0811682985', history.kosan);
                    },
                    label: "Hubungi Pemilik",
                  )
                : ButtonWidget(
                    onPressed: () {
                      di.get<AppRouter>().popAndPush(MainRoute(initialPage: 0));
                    },
                    height: 50,
                    label: "Cari Kos lain",
                  ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kosanSection(context),
              dataPenyewaSection(),
              detailPenyewaanSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget kosanSection(BuildContext context) {
    String baseUrl = dotenv.get('URL');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          history.status.label,
          style: lBold.copyWith(
            color: getStatusColor(history.status),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  history.kosan.name,
                  style: mSemibold,
                ),
                Text(
                  history.kosan.address,
                  style: mSemibold,
                ),
                const SizedBox(height: 8.0),
                Text(
                  history.kosan.genderCategory,
                  style: sRegular,
                ),
              ],
            ),
            if (history.kosan.imagesPaths.isNotEmpty) ...[
              CustomBoxImage(
                imageUrl: "$baseUrl/${history.kosan.imagesPaths[0]}",
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
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text.rich(
          TextSpan(
            text: numberFormat.format(history.kosan.price),
            children: [TextSpan(text: ' / bulan', style: sRegular)],
          ),
          style: mSemibold,
        ),
        const SizedBox(height: 8.0),
        TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return FasilitasKosan(facilities: history.kosan.facilities);
              },
            );
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            // textStyle: sRegular.copyWith(color: primaryColor),
          ),
          child: Text('Lihat Fasilitas',
              style: sRegular.copyWith(color: primaryColor)),
        ),
        const Divider(
          color: Colors.black45,
          thickness: 0.6,
        ),
      ],
    );
  }

  Widget dataPenyewaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Data Penyewa",
          style: lSemibold,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nama',
              style: mRegular,
            ),
            Text(
              history.penyewa.name,
              style: mSemibold,
            ),
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nomor Telphone',
              style: mRegular,
            ),
            Text(
              history.penyewa.phoneNumber,
              style: mSemibold,
            ),
          ],
        ),
        const Divider(
          color: Colors.black45,
          thickness: 0.6,
        ),
      ],
    );
  }

  detailPenyewaanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Detail Penyewaan",
          style: lSemibold,
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nomor ID Sewa',
              style: mRegular,
            ),
            Text(
              history.id.toString(),
              style: mMedium,
            ),
          ],
        ),
        // const SizedBox(height: 15.0),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 1,
          width: double.infinity,
          color: Colors.black38,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mulai Sewa',
              style: mRegular,
            ),
            Text(
              DateFormat('d MMM y').format(history.tanggalMulai),
              style: mMedium,
            ),
          ],
        ),
        // const SizedBox(height: 15.0),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 1,
          width: double.infinity,
          color: Colors.black38,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sewa Berakhir',
              style: mRegular,
            ),
            Text(
              DateFormat('d MMM y').format(history.tanggalSelesai),
              style: mMedium,
            ),
          ],
        ),
        // const SizedBox(height: 15.0),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 1,
          width: double.infinity,
          color: Colors.black38,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Durasi Sewa',
              style: mRegular,
            ),
            Text(
              "${history.durasiSewa} Bulan",
              style: mMedium,
            ),
          ],
        ),
        // const SizedBox(height: 15.0),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 1,
          width: double.infinity,
          color: Colors.black38,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Harga per bulan',
              style: mRegular,
            ),
            Text(
              numberFormat.format(history.kosan.price),
              style: mMedium,
            ),
          ],
        ),
        // const SizedBox(height: 15.0),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 1,
          width: double.infinity,
          color: Colors.black38,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total harga sewa',
              style: mRegular,
            ),
            Text(
              numberFormat.format(history.total),
              style: mMedium,
            ),
          ],
        ),
      ],
    );
  }
}
