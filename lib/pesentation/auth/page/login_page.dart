import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/app/data/models/auth/login_model.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/pesentation/auth/components/custom_textfield_widget.dart';
import 'package:maukos_app/pesentation/auth/cubit/auth_cubit.dart';
import 'package:maukos_app/routes/app_router.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController emailController =
      TextEditingController(text: 'admin@gmail.com');
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController =
      TextEditingController(text: 'password');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return Scaffold(
              backgroundColor: primaryColor,
              body: SingleChildScrollView(child: loginWeb()));
        } else {
          return Scaffold(body: SingleChildScrollView(child: loginMobile()));
        }
      },
    );
  }

  Widget loginWeb() {
    return Builder(builder: (context) {
      return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 64, vertical: defaultMargin),
        child: Center(
          child: Container(
            width: 600,
            padding: const EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                bottom: defaultMargin),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 50, bottom: 30),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset("assets/images/logo.png"),
                ),
                Text(
                  "Login",
                  style: textStyle.copyWith(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Cari dan temukan property terbaik",
                  style: textStyle.copyWith(
                      fontSize: 14,
                      color: Colors.black38,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Email",
                  style: textStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: defaultMargin),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Masuk email anda",
                        border: InputBorder.none,
                        hintStyle: textStyle.copyWith(color: Colors.black38)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Password",
                  style: textStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(left: defaultMargin),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: "Masuk password anda",
                        border: InputBorder.none,
                        hintStyle: textStyle.copyWith(color: Colors.black38)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 18, bottom: 12),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.all(16),
                          textStyle:
                              textStyle.copyWith(fontWeight: FontWeight.bold)),
                      child: const Text("Sign In")),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum memiliki akun ? ",
                      style: textStyle.copyWith(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Daftar",
                        style: textStyle.copyWith(
                          fontSize: 14,
                          color: secondColor,
                          fontWeight: FontWeight.w500,
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
    });
  }

  Widget loginMobile() {
    return Builder(builder: (context) {
      return Container(
        padding:
            const EdgeInsets.only(left: defaultMargin, right: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(top: 50, bottom: 30),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset("assets/images/logo.png"),
            ),
            Text(
              "Login",
              style:
                  textStyle.copyWith(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              "Cari dan temukan kos terbaik",
              style: textStyle.copyWith(
                fontSize: 14,
                color: Colors.black38,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: emailController,
              label: 'Email',
              hintText: 'Masukkan email anda',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Password',
              hintText: 'Masukkan password anda',
              controller: passController,
              obscureText: true,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoaded) {
                  AutoRouter.of(context).replace(const MainRoute());
                }
                if (state is AuthError) {
                  log("ADA ERROR BRO =>  ${state.message}");
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Login Failed")));
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Container(
                    margin: const EdgeInsets.only(top: 18, bottom: 12),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  );
                }
                return Container(
                  margin: const EdgeInsets.only(top: 18, bottom: 12),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().login(LoginModel(
                          emailController.text, passController.text));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Text(
                      "Login",
                      style: textStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum memiliki akun ? ",
                  style: textStyle.copyWith(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    AutoRouter.of(context).replace(RegisterRoute());
                  },
                  child: Text(
                    "Daftar",
                    style: textStyle.copyWith(
                      fontSize: 14,
                      color: secondColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
