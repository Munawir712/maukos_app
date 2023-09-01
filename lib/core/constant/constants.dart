import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maukos_app/app/domain/entities/kos/kos_entity.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/data/models/history/history_penyewaan_response_model.dart';
import '../themes/color.dart';

// size
const double defaultMargin = 18;

// assets path
const assetImage = "assets/images";
const assetIcon = "assets/icon";

final numberFormat =
    NumberFormat.currency(symbol: "Rp ", decimalDigits: 0, locale: "id-ID");

/// Device size
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

Color? getStatusColor(HistoryStatus history) {
  switch (history) {
    case HistoryStatus.sedangDisewa:
      return primaryColor;
    case HistoryStatus.selesai:
      return primaryColor;
    case HistoryStatus.belumDikonfirmasi:
      return Colors.yellow[700];
    case HistoryStatus.dikonfirmasi:
      return Colors.blue[300];
    case HistoryStatus.dibatalkan:
      return Colors.grey[600];
    case HistoryStatus.jatuhTempo:
      return Colors.red[600];
    default:
      return Colors.transparent;
  }
}

Future<void> launchWhatApp(String phoneNumber, KosEntity kosEntity,
    {HistoryPenyewaanResponseModel? history}) async {
  String text =
      "${kosEntity.name} | No. ${kosEntity.numberKos} | Harga ${numberFormat.format(kosEntity.price)}/Bulan \n ";
  if (history != null) {
    text =
        "Id Penyewaan: ${history.id} | ${kosEntity.name} | No. ${kosEntity.numberKos} | Harga ${numberFormat.format(kosEntity.price)}/Bulan \n ";
  }
  String message = Uri.encodeComponent(text);
  final url = 'whatsapp://send?phone=$phoneNumber&text=$message';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    log('Tidak dapat launch WhatApp');
  }
}
