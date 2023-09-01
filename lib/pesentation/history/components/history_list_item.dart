import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maukos_app/app/data/models/history/history_penyewaan_response_model.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/core/widget/custom_box_image.dart';
import 'package:maukos_app/pesentation/history/page/history_detail_page.dart';

class HistoryListItem extends StatelessWidget {
  final String name;
  final HistoryPenyewaanResponseModel history;
  final BoxBorder? border;
  const HistoryListItem({
    Key? key,
    required this.name,
    required this.history,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String baseUrl = dotenv.get('URL');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HistoryDetailPage(
                    history: history,
                  )),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
        decoration: BoxDecoration(
            color: whiteColor,
            border: border,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black45.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 5))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  history.status.label,
                  style: mSemibold.copyWith(
                    color: getStatusColor(history.status),
                  ),
                ),
                Text(
                  DateFormat('d MMM y HH:mm').format(history.createdAt),
                  style: mMedium.copyWith(color: Colors.black38),
                ),
              ],
            ),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      (2 * 16) -
                      60 -
                      10 -
                      40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: mSemibold,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Total bayar : ${numberFormat.format(history.total)}",
                        style: mMedium.copyWith(color: Colors.black38),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.black45,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Tanggal masuk",
                                    style: sSemibold.copyWith(
                                        color: Colors.black45),
                                  )
                                ],
                              ),
                              Text(
                                DateFormat('d MMM y')
                                    .format(history.tanggalMulai),
                                style: sMedium.copyWith(color: Colors.black87),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_outlined,
                                    color: Colors.black45,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Durasi Sewa",
                                    style: sSemibold.copyWith(
                                        color: Colors.black45),
                                  )
                                ],
                              ),
                              Text(
                                "${history.durasiSewa} Bulan",
                                style: sMedium.copyWith(color: Colors.black87),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
