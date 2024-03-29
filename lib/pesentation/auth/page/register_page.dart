import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/app/data/models/auth/register_model.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';
import 'package:maukos_app/core/widget/button_widget.dart';
import 'package:maukos_app/core/widget/custom_flushbar_message.dart';
import 'package:maukos_app/injection.dart';
import 'package:maukos_app/pesentation/auth/components/custom_textfield_widget.dart';
import 'package:maukos_app/pesentation/auth/cubit/auth_cubit.dart';
import 'package:maukos_app/routes/app_router.dart';
import 'package:unicons/unicons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  String? jenisKelamin = "pria";
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AutoRouter.of(context).replace(const LoginRoute());
        return false;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.minWidth > 600) {
            return Scaffold(
                backgroundColor: primaryColor,
                body: SingleChildScrollView(child: loginWeb()));
          } else {
            return Scaffold(
                body: SingleChildScrollView(child: registerMobile()));
          }
        },
      ),
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
                  controller: usernameController,
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

  Widget registerMobile() {
    return Builder(builder: (context) {
      return Container(
        padding:
            const EdgeInsets.only(left: defaultMargin, right: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  },
                  color: whiteColor,
                  icon: const Icon(UniconsLine.arrow_left),
                ),
              ),
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
              controller: usernameController,
              label: 'Username',
              hintText: 'Masukkan username anda',
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
            Text(
              "Jenis Kelamin",
              style:
                  textStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomSelectedRadio(
                  label: 'Laki-laki',
                  value: 'pria',
                  groupValue: jenisKelamin,
                  onChanged: (value) {
                    setState(() {
                      jenisKelamin = value!;
                    });
                  },
                ),
                CustomSelectedRadio(
                  label: 'Perempuan',
                  value: 'wanita',
                  groupValue: jenisKelamin,
                  onChanged: (value) {
                    setState(() {
                      jenisKelamin = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Password',
              hintText: 'Masukkan password anda',
              controller: passController,
              obscureText: obscureText,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon:
                    Icon(obscureText ? UniconsLine.eye : UniconsLine.eye_slash),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 18, bottom: 12),
              width: double.infinity,
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthRegisterSuccess) {
                    Future.delayed(const Duration(seconds: 2), () async {
                      log("push lah");
                      di.get<AppRouter>().replace(const LoginRoute());
                    });
                    CustomFlushBarMessage.message(
                      title: 'Sukses',
                      message: state.message,
                      position: FlushbarPosition.TOP,
                    ).show(context);
                  }
                  if (state is AuthError) {
                    log("ADA Register ERROR BRO =>  ${state.message}");
                    CustomFlushBarMessage.message(
                      title: 'Mohon maaf',
                      message: state.message,
                      isFailed: true,
                      position: FlushbarPosition.TOP,
                    ).show(context);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return ButtonWidget(
                      width: double.infinity,
                      height: 55,
                      onPressed: () {},
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    );
                  }
                  return ButtonWidget(
                    width: double.infinity,
                    height: 55,
                    label: 'Daftar',
                    onPressed: () {
                      if (jenisKelamin != null) {
                        context.read<AuthCubit>().register(RegisterModel(
                              nameController.text,
                              usernameController.text,
                              phoneController.text,
                              passController.text,
                              jenisKelamin!,
                            ));
                      }
                    },
                  );
                },
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
                    // AutoRouter.of(context).popUntilRoot();
                    // AutoRouter.of(context).replace(const LoginRoute());
                    di.get<AppRouter>().pop();
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

class CustomSelectedRadio extends StatelessWidget {
  final String value;
  final String label;
  final FocusNode? focusNode;
  final String? groupValue;
  final void Function(String?) onChanged;
  const CustomSelectedRadio({
    required this.label,
    required this.value,
    this.focusNode,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Theme(
            data: Theme.of(context)
                .copyWith(unselectedWidgetColor: Colors.black38),
            child: Radio(
                focusNode: focusNode,
                value: value,
                activeColor: primaryColor,
                groupValue: groupValue,
                onChanged: onChanged),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        InkWell(
          onTap: () {
            onChanged(value);
          },
          child: Text(
            label,
            style: textStyle.copyWith(),
          ),
        ),
      ],
    );
  }
}
