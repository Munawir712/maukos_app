import 'package:flutter/material.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:unicons/unicons.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(UniconsLine.user_circle),
        ),
        title: Text(
          "Dashboard",
          style: textStyle.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                "Selamat Datang Pemilik",
                style: textStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  MenuCard(
                    title: "Data Kos",
                    icon: UniconsLine.home,
                  ),
                  MenuCard(
                    title: "Data Penyewa",
                    icon: UniconsLine.users_alt,
                  ),
                  MenuCard(
                    title: "Data Penyewa",
                    icon: UniconsLine.file_edit_alt,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    this.title,
    this.icon,
    this.backgroundColor,
  });

  final String? title;
  final IconData? icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
