import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/injection.dart';
import 'package:maukos_app/pesentation/auth/cubit/auth_cubit.dart';
import 'package:maukos_app/routes/app_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 110,
                width: double.infinity,
                color: primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return CircularProgressIndicator();
                    }
                    if (state is AuthLoaded) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              height: 60,
                              width: 60,
                              margin: const EdgeInsets.only(right: 10),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Color(0xFFDEDEDE),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                state.user.name!.substring(0, 1),
                                style: textStyle.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: defaultMargin,
                                ),
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.user.name ?? '',
                                style: textStyle.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                state.user.email,
                                style: textStyle.copyWith(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Edit Profile",
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.black38,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bookmark",
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.black38,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notification",
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.black38,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Security",
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.black38,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Help",
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.black38,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "About",
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.black38,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
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
                                style:
                                    textStyle.copyWith(color: Colors.black54),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor),
                                  child: Text("No"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<AuthCubit>().logout();
                                    di.get<AppRouter>().replace(LoginRoute());
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sign Out",
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.black38,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
