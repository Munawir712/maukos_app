import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/core/themes/textstyle.dart';

import '../../../core/constant/constants.dart';
import '../../../core/themes/color.dart';
import '../../../injection.dart';
import '../../../routes/app_router.dart';
import '../../auth/cubit/auth_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        Future.delayed(const Duration(seconds: 2), () {
          if (state is AuthLoaded) {
            final user = state.user;
            if (user.roles == 'ADMIN') {
              di.get<AppRouter>().replaceNamed('/admin');
            } else {
              di.get<AppRouter>().replace(MainRoute());
            }
          }
          if (state is AuthError) {
            log(state.message);
            di.get<AppRouter>().replace(MainRoute());
          }
        });
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                "$assetImage/logo.png",
                width: 130,
                height: 100,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 7),
                  Text(
                    "Powered by",
                    style: sRegular,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "Wir Dev",
                    style: sBold,
                  ),
                  const SizedBox(
                    height: 95,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
