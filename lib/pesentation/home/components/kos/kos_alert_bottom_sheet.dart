import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/color.dart';
import '../../../../core/themes/textstyle.dart';
import '../../../../injection.dart';
import '../../../../routes/app_router.dart';

class KosBottomSheet {
  static showDatePicker(
    BuildContext context, {
    required List<DateTime> initialDate,
    required VoidCallback? onConfirm,
    ValueChanged<List<DateTime?>>? onValueChanged,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final config = CalendarDatePicker2Config(
          selectedDayHighlightColor: primaryColor,
          weekdayLabels: ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'],
          weekdayLabelTextStyle: mMedium.copyWith(color: Colors.black87),
          firstDayOfWeek: 1,
          controlsHeight: 50,
          controlsTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          dayTextStyle: const TextStyle(color: Colors.black),
          disabledDayTextStyle: const TextStyle(
            color: Colors.grey,
          ),
          selectableDayPredicate: (day) => !day
              .difference(DateTime.now().subtract(const Duration(days: 3)))
              .isNegative,
        );
        return Scaffold(
          body: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    di.get<AppRouter>().pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Pilih Tanggal Mulai ngekos',
                  style: lMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CalendarDatePicker2(
                  config: config,
                  value: initialDate,
                  onValueChanged: onValueChanged,
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                onConfirm?.call();
                di.get<AppRouter>().pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                textStyle: textStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text("Sewa"),
            ),
          ),
        );
      },
    );
  }

  static showKosGenderInvalid(BuildContext context,
      {String? title, String? desc}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Center(
                child: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 200,
                ),
              ),
              Text(
                title ?? "Kos ini Khusus untuk perempuan",
                style: lBold,
              ),
              const SizedBox(height: 8.0),
              Text(
                desc ??
                    "Mohon maaf, hanya penyewa perempuan yang dapat menyewa kos putri.",
                style: sRegular,
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    di.get<AppRouter>().pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      textStyle: textStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  child: const Text("Saya Mengerti"),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        );
      },
    );
  }
}
