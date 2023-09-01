import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/core/widget/custom_flushbar_message.dart';
import 'package:maukos_app/pesentation/auth/cubit/auth_cubit.dart';
import 'package:unicons/unicons.dart';

import '../../../injection.dart';
import '../../../routes/app_router.dart';
import '../components/menu_card.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Dashboard",
          style: lSemibold,
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  di.get<AppRouter>().push(const ProfileAdminRoute());
                },
                textStyle: mMedium.copyWith(color: Colors.black),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      UniconsLine.user_circle,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8.0),
                    Text('Profile')
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Peringatan',
                            style: textStyle,
                          ),
                          content: Text(
                            "Apakah Anda yakin untuk keluar",
                            style: textStyle.copyWith(color: Colors.black54),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor),
                              child: const Text("No"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.read<AuthCubit>().logout();
                                di.get<AppRouter>().popUntilRoot();
                                di
                                    .get<AppRouter>()
                                    .replace(MainRoute(initialPage: 0));
                                CustomFlushBarMessage.message(
                                  title: 'Sukses',
                                  message: "Logout berhasil",
                                  position: FlushbarPosition.TOP,
                                ).show(context);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(
                                      color: Colors.red.shade400,
                                      width: 2,
                                    )),
                                backgroundColor: Colors.white,
                              ),
                              child: Text(
                                "Yes",
                                style: textStyle.copyWith(
                                  color: Colors.red.shade400,
                                ),
                              ),
                            )
                          ],
                        );
                      });
                },
                textStyle: mMedium.copyWith(color: Colors.black),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      UniconsLine.signout,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8.0),
                    Text('Logout')
                  ],
                ),
              ),
            ],
          ),
        ],
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
                    onPressed: () {},
                  ),
                  MenuCard(
                    title: "Data Penyewa",
                    icon: UniconsLine.users_alt,
                    onPressed: () {},
                  ),
                  MenuCard(
                    title: "Data Penyewa",
                    icon: UniconsLine.file_edit_alt,
                    onPressed: () {},
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
