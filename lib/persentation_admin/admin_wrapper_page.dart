import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AdminWrapperPage extends StatelessWidget {
  const AdminWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AutoRouter(),
    );
  }
}
