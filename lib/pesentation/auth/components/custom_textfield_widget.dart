import 'package:flutter/material.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/textstyle.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
  });

  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? "",
          style: textStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.only(left: defaultMargin),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText ?? "",
              border: InputBorder.none,
              hintStyle: textStyle.copyWith(color: Colors.black38),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
