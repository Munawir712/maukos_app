import 'package:flutter/material.dart';
import 'package:maukos_app/app/data/models/kos/facilities_model.dart';
import 'package:maukos_app/pesentation/home/components/kos/kos_detail_page.dart';

import '../../../core/themes/textstyle.dart';

class FasilitasKosan extends StatelessWidget {
  const FasilitasKosan({super.key, required this.facilities});
  final List<FacilityModel> facilities;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fasilitas Kos",
              style: lSemibold,
            ),
            const Divider(
              color: Colors.black45,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 5,
              children: facilities
                  .map((e) => FasilitasBoxWidget(fasilitas: e))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
