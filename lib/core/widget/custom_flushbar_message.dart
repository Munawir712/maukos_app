import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';

class CustomFlushBarMessage {
  static Flushbar message(
      {required String title,
      required String message,
      Color? backgroundColor,
      Duration duration = const Duration(seconds: 3),
      bool? isFailed = false,
      Icon? icon,
      FlushbarPosition? position}) {
    return Flushbar(
      titleText: Text(
        title,
        style: lSemibold.copyWith(fontSize: 16, color: whiteColor),
      ),
      messageText: Text(
        message,
        style: lSemibold.copyWith(
            fontSize: 15, color: whiteColor, overflow: TextOverflow.ellipsis),
        maxLines: 2,
      ),
      icon: (icon == null)
          ? (isFailed == true)
              ? const Icon(
                  Icons.cancel_outlined,
                  color: whiteColor,
                )
              : const Icon(
                  Icons.check_box_outlined,
                  color: whiteColor,
                )
          : icon,
      backgroundColor: (backgroundColor == null)
          ? (isFailed == true)
              ? redColor
              : primaryColor
          : backgroundColor,
      margin: const EdgeInsets.only(top: kToolbarHeight),
      padding: const EdgeInsets.all(20),
      flushbarPosition: position ?? FlushbarPosition.BOTTOM,
      duration: duration,
    );
  }
}
