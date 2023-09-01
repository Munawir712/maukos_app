import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/app/data/models/history/history_penyewaan_response_model.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/core/widget/custom_flushbar_message.dart';
import 'package:maukos_app/injection.dart';
import 'package:maukos_app/pesentation/history/cubit/history_cubit.dart';

import '../components/history_list_item.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List tabs = [
    'Semua',
    'Berlangsung',
    'Belum dikonfirmasi',
    'Selesai',
    'Dibatalkan',
  ];
  late int selectedIndex;
  bool hasSewa = true;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    di.get<HistoryCubit>().getAllHistory();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      listener: (context, state) {
        if (state is HistoryError) {
          CustomFlushBarMessage.message(
            title: 'Peringatan',
            message: state.message,
          ).show(context);
        }
        if (state is HistoryInitial) {
          di.get<HistoryCubit>().getAllHistory();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Riwayat Penyewaan',
              style: textStyle.copyWith(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: primaryColor,
            elevation: 0,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<HistoryCubit>().getAllHistory();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  customTabBar(),
                  const Divider(),
                  Builder(
                    builder: (context) {
                      if (state is HistoryLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is HistoryError) {
                        return Center(child: Text(state.message));
                      } else if (state is HistoryLoaded) {
                        final histories = getFilteredHistories(
                            state.histories, selectedIndex);
                        final jatuhTempoHistory = histories
                            .where((e) => e.status == HistoryStatus.jatuhTempo)
                            .toList();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (jatuhTempoHistory.isNotEmpty) ...[
                              Container(
                                color: Colors.red[100],
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 20, top: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      'Ada Penyewaan Jatuh Tempo',
                                      style: lBold.copyWith(
                                        color: Colors.red[600],
                                      ),
                                    ),
                                    Text(
                                      'Segera selesaikan, hubungin pemilik kos untuk konfirmasi pembayaran dll.',
                                      style: mLight,
                                    ),
                                    const SizedBox(height: 5),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: jatuhTempoHistory.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return HistoryListItem(
                                          name: jatuhTempoHistory[index]
                                              .kosan
                                              .name,
                                          history: jatuhTempoHistory[index],
                                          border: Border.all(
                                              color: Colors.red.shade600,
                                              width: 2),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: histories.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final history = histories[index];
                                // log(history.status.label);
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 12,
                                    left: 12,
                                    right: 12,
                                  ),
                                  child: HistoryListItem(
                                    history: history,
                                    name: history.kosan.name,
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      } else {
                        // Handle other states if needed.
                        return Container();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
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
            return const SizedBox();
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

  List<HistoryPenyewaanResponseModel> getFilteredHistories(
      List<HistoryPenyewaanResponseModel> histories, int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return histories;
      case 1:
        return histories
            .where((e) => e.status == HistoryStatus.sedangDisewa)
            .toList();
      case 2:
        return histories
            .where((e) => e.status == HistoryStatus.belumDikonfirmasi)
            .toList();
      case 3:
        return histories
            .where((e) => e.status == HistoryStatus.selesai)
            .toList();
      case 4:
        return histories
            .where((e) => e.status == HistoryStatus.dibatalkan)
            .toList();

      default:
        return [];
    }
  }
}
