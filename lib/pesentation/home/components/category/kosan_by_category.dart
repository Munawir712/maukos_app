import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/constants.dart';
import '../../../../core/themes/color.dart';
import '../../../../core/themes/textstyle.dart';
import '../../../../injection.dart';
import '../../../../routes/app_router.dart';
import '../../cubit/kos_cubit.dart';
import '../kos/card_kos.dart';

class KosanByCategory extends StatefulWidget {
  const KosanByCategory({super.key});

  @override
  State<KosanByCategory> createState() => _KosanByCategoryState();
}

class _KosanByCategoryState extends State<KosanByCategory> {
  String category = 'minimalis';

  List<String> categories = ['Minimalis', 'Reguler', 'Premium'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Row(
            children: categories
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.only(
                      left: categories.first == e ? defaultMargin : 0,
                      right: 8,
                    ),
                    child: CategoryTabItem(
                      label: e,
                      isSelected: category == e.toLowerCase(),
                      onTap: () {
                        setState(() {
                          category = e.toLowerCase();
                        });
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 250,
          alignment: Alignment.centerLeft,
          // padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: BlocConsumer<KosCubit, KosState>(
            listener: (context, state) {
              if (state is KosFailed) {
                log(state.message);
              }
            },
            builder: (context, state) {
              if (state is KosLoaded) {
                final kosList = state.kosEntity
                    .where((e) => e.category == category)
                    .toList();
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: kosList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: index == 0 ? defaultMargin : 0, right: 16),
                        child: InkWell(
                          onTap: () {
                            di.get<AppRouter>().push(
                                KosDetailRoute(kosEntity: kosList[index]));
                          },
                          child: CardKos(
                            width: 230,
                            kosEntity: kosList[index],
                          ),
                        ),
                      );
                    });
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
}

class CategoryTabItem extends StatelessWidget {
  const CategoryTabItem({
    super.key,
    required this.label,
    this.labelTextStyle,
    this.onTap,
    this.isSelected = false,
  });
  final String label;
  final TextStyle? labelTextStyle;
  final Function()? onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          border: Border.all(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          label,
          style: labelTextStyle ??
              mMedium.copyWith(color: isSelected ? whiteColor : primaryColor),
        ),
      ),
    );
  }
}
