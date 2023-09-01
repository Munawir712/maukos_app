import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/injection.dart';
import 'package:maukos_app/pesentation/home/components/kos/card_kos.dart';
import 'package:maukos_app/pesentation/search/cubit/search_kos_cubit.dart';
import 'package:maukos_app/routes/app_router.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    di.get<SearchKosCubit>().searchKos('');
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: defaultMargin, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cari Kos",
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 45,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFDEDEDE),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: "Cari",
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      di.get<SearchKosCubit>().searchKos(text);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    searchController.clear();
                    di.get<SearchKosCubit>().searchKos(searchController.text);
                  },
                  icon: Icon(
                    Icons.cancel_sharp,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<SearchKosCubit, SearchKosState>(
            builder: (context, state) {
              if (state is SearchKosLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is SearchKosLoaded) {
                final listKos = state.kosEntity;
                if (listKos.isEmpty) {
                  return const Center(
                    child: Text("Data kos ditemukan"),
                  );
                }
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  shrinkWrap: true,
                  itemCount: listKos.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        di
                            .get<AppRouter>()
                            .push(KosDetailRoute(kosEntity: listKos[index]));
                      },
                      child: CardKos(
                        kosEntity: listKos[index],
                        height: 245,
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: Text("Data tidak ditemukan"),
              );
            },
          ),
        ],
      ),
    );
  }
}
