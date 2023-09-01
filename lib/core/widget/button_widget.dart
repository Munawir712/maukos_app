import 'package:flutter/material.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onPressed,
    this.child,
    this.height,
    this.width,
    this.backgroundColor,
    this.label,
    this.labelStyle,
  });

  final Function()? onPressed;
  final Widget? child;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final String? label;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: child ??
            Text(
              label ?? '',
              style: labelStyle ?? mSemibold.copyWith(color: whiteColor),
            ),
      ),
    );
  }
}
