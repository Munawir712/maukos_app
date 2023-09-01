import 'package:flutter/material.dart';

import '../../../core/themes/color.dart';
import '../../../core/themes/textstyle.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    this.title,
    this.icon,
    this.backgroundColor,
    this.onPressed,
  });

  final String? title;
  final IconData? icon;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 110,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            const SizedBox(height: 12),
            Text(
              title ?? '',
              style: textStyle.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
