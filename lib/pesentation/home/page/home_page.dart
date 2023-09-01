import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/core/widget/custom_flushbar_message.dart';
import 'package:maukos_app/pesentation/home/components/kos/card_kos.dart';
import 'package:maukos_app/pesentation/home/components/kos/kos_detail_page.dart';
import 'package:maukos_app/pesentation/home/cubit/kos_cubit.dart';

import '../../../injection.dart';
import '../components/category/kosan_by_category.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    di.get<KosCubit>().getAllKos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<KosCubit>().getAllKos();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* App bar
                appBarSection(),
                const SizedBox(
                  height: 30,
                ),
                forYouSection(context),
                categorySection(),
                const SizedBox(height: 30),
                kosByGenderSection(gender: "PUTRI", title: "Kos Khusus Putri"),
                const SizedBox(height: 30),
                kosByGenderSection(gender: "PUTRA", title: "Kos Khusus Putra"),
                const SizedBox(height: 30),
                kosByGenderSection(gender: "CAMPURAN", title: "Kos Keluarga"),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container appBarSection() {
    return Container(
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
          // Container(
          //   height: 38,
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //     color: secondColor,
          //     borderRadius: BorderRadius.circular(4),
          //   ),
          //   child: Center(
          //     child: IconButton(
          //       onPressed: () {},
          //       icon: const Icon(
          //         UniconsLine.bell,
          //         size: 24,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget forYouSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultMargin, bottom: 10),
          child: Text("Untuk anda", style: lSemibold),
        ),
        SizedBox(
          height: 230,
          child: BlocConsumer<KosCubit, KosState>(
            listener: (context, state) {
              if (state is KosInitial) {
                di.get<KosCubit>().getAllKos();
              }
              if (state is KosFailed) {
                CustomFlushBarMessage.message(
                  title: 'Peringatan',
                  isFailed: true,
                  message: state.message,
                  position: FlushbarPosition.TOP,
                ).show(context);
              }
            },
            builder: (context, state) {
              if (state is KosLoaded) {
                final kosList = state.kosEntity.take(5).toList();
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: kosList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? defaultMargin : 0, right: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  KosDetailPage(kosEntity: kosList[index]),
                            ),
                          );
                        },
                        child: CardKos(
                          width: 230,
                          kosEntity: kosList[index],
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget categorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 12,
          ),
          child: Text(
            "Kategori",
            style: lSemibold,
          ),
        ),
        const KosanByCategory(),
      ],
    );
  }

  Widget kosByGenderSection({required String gender, String? title}) {
    return BlocConsumer<KosCubit, KosState>(listener: (context, state) {
      if (state is KosInitial) {
        di.get<KosCubit>().getAllKos();
      }
      if (state is KosFailed) {
        CustomFlushBarMessage.message(
          title: 'Peringatan',
          isFailed: true,
          message: state.message,
          position: FlushbarPosition.TOP,
        ).show(context);
      }
    }, builder: (context, state) {
      if (state is KosLoaded) {
        final kosList =
            state.kosEntity.where((e) => e.genderCategory == gender).toList();
        if (kosList.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: defaultMargin, bottom: 10),
                child: Text(title ?? "", style: lSemibold),
              ),
              SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: kosList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? defaultMargin : 0, right: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  KosDetailPage(kosEntity: kosList[index]),
                            ),
                          );
                        },
                        child: CardKos(
                          width: 230,
                          kosEntity: kosList[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      }
      return const Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      );
    });
  }
}
