import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/pesentation/auth/components/custom_textfield_widget.dart';
import 'package:maukos_app/routes/app_router.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();

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
                  "Register",
                  style: textStyle.copyWith(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Daftar sekarang dan temukan kos terbaik",
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
                  controller: nameController,
                  label: 'Nama',
                  hintText: 'Masukkan nama anda',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
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
                  controller: phoneController,
                  label: 'Nomor Hanphone',
                  hintText: 'Masukkan nomor handphone anda',
                  keyboardType: TextInputType.phone,
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
                      "Sudah memiliki akun ? ",
                      style: textStyle.copyWith(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        AutoRouter.of(context).popUntilRoot();
                      },
                      child: Text(
                        "Login",
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
              "Register",
              style:
                  textStyle.copyWith(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              "Daftar sekarang dan temukan kos terbaik",
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
              controller: nameController,
              label: 'Nama',
              hintText: 'Masukkan nama anda',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 10,
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
              controller: phoneController,
              label: 'Nomor Hanphone',
              hintText: 'Masukkan nomor handphone anda',
              keyboardType: TextInputType.phone,
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
            Container(
              margin: const EdgeInsets.only(top: 18, bottom: 12),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).replace(const MainRoute());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.all(16),
                ),
                child: Text(
                  "Daftar",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sudah memiliki akun ? ",
                  style: textStyle.copyWith(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    AutoRouter.of(context).popUntilRoot();
                  },
                  child: Text(
                    "Login",
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
