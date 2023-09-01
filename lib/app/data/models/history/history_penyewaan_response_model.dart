// To parse this JSON data, do
//
//     final historyPenyewaanResponseModel = historyPenyewaanResponseModelFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

import 'package:maukos_app/app/data/models/kos/kos_response_model.dart';
import 'package:maukos_app/app/domain/entities/kos/kos_entity.dart';

import '../auth/penyewa_model.dart';

class HistoryPenyewaanResponseModel {
  final int id;
  final int penyewaId;
  final int kosanId;
  final DateTime tanggalMulai;
  final DateTime tanggalSelesai;
  final int durasiSewa;
  final int jumlahOrang;
  final HistoryStatus status;
  final int confirmed;
  final int total;
  final DateTime createdAt;
  final int updatedAt;
  final PenyewaModel penyewa;
  final KosEntity kosan;

  HistoryPenyewaanResponseModel({
    required this.id,
    required this.penyewaId,
    required this.kosanId,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.durasiSewa,
    required this.jumlahOrang,
    required this.status,
    required this.confirmed,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.penyewa,
    required this.kosan,
  });

  HistoryPenyewaanResponseModel copyWith({
    int? id,
    int? penyewaId,
    int? kosanId,
    DateTime? tanggalMulai,
    DateTime? tanggalSelesai,
    int? durasiSewa,
    int? jumlahOrang,
    HistoryStatus? status,
    int? confirmed,
    int? total,
    DateTime? createdAt,
    int? updatedAt,
    PenyewaModel? penyewa,
    KosEntity? kosan,
  }) =>
      HistoryPenyewaanResponseModel(
        id: id ?? this.id,
        penyewaId: penyewaId ?? this.penyewaId,
        kosanId: kosanId ?? this.kosanId,
        tanggalMulai: tanggalMulai ?? this.tanggalMulai,
        tanggalSelesai: tanggalSelesai ?? this.tanggalSelesai,
        durasiSewa: durasiSewa ?? this.durasiSewa,
        jumlahOrang: jumlahOrang ?? this.jumlahOrang,
        status: status ?? this.status,
        confirmed: confirmed ?? this.confirmed,
        total: total ?? this.total,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        penyewa: penyewa ?? this.penyewa,
        kosan: kosan ?? this.kosan,
      );

  factory HistoryPenyewaanResponseModel.fromRawJson(String str) =>
      HistoryPenyewaanResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoryPenyewaanResponseModel.fromJson(Map<String, dynamic> json) =>
      HistoryPenyewaanResponseModel(
        id: json["id"],
        penyewaId: json["penyewa_id"],
        kosanId: json["kosan_id"],
        tanggalMulai: DateTime.parse(json["tanggal_mulai"]),
        tanggalSelesai: DateTime.parse(json["tanggal_selesai"]),
        durasiSewa: json["durasi_sewa"],
        jumlahOrang: json['jumlah_orang'],
        status: HistoryStatus.fromString(json['status']),
        confirmed: json["confirmed"],
        total: json["total"],
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(json["created_at"] * 1000 ?? 0),
        updatedAt: json["updated_at"],
        penyewa: PenyewaModel.fromJson(json["penyewa"]),
        kosan: KosResponseModel.fromJson(json["kosan"] ?? {}).toEntity(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "penyewa_id": penyewaId,
        "kosan_id": kosanId,
        "tanggal_mulai":
            "${tanggalMulai.year.toString().padLeft(4, '0')}-${tanggalMulai.month.toString().padLeft(2, '0')}-${tanggalMulai.day.toString().padLeft(2, '0')}",
        "tanggal_selesai":
            "${tanggalSelesai.year.toString().padLeft(4, '0')}-${tanggalSelesai.month.toString().padLeft(2, '0')}-${tanggalSelesai.day.toString().padLeft(2, '0')}",
        "durasi_sewa": durasiSewa,
        "jumlah_orang": jumlahOrang,
        "status": status,
        "confirmed": confirmed,
        "total": total,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "penyewa": penyewa.toJson(),
        // "kosan": kosan.toJson(),
      };
}

class HistoryStatus {
  final String _value;

  const HistoryStatus._(this._value);

  static const HistoryStatus belumDikonfirmasi =
      HistoryStatus._('belum_dikonfirmasi');
  static const HistoryStatus menungguPembayaran =
      HistoryStatus._('menunggu_pembayaran');
  static const HistoryStatus dikonfirmasi = HistoryStatus._('dikonfirmasi');
  static const HistoryStatus sedangDisewa = HistoryStatus._('sedang_disewa');
  static const HistoryStatus selesai = HistoryStatus._('selesai');
  static const HistoryStatus dibatalkan = HistoryStatus._('dibatalkan');
  static const HistoryStatus belumBayar = HistoryStatus._('belum_bayar');
  static const HistoryStatus dalamProses = HistoryStatus._('dalam_proses');
  static const HistoryStatus jatuhTempo = HistoryStatus._('jatuh_tempo');

  static const Map<String, String> _statusLabels = {
    'belum_dikonfirmasi': 'Menunggu Konfirmasi',
    'menunggu_pembayaran': 'Menunggu Pembayaran',
    'dikonfirmasi': 'Dikonfirmasi',
    'sedang_disewa': 'Sedang Disewa',
    'selesai': 'Selesai',
    'dibatalkan': 'Dibatalkan',
    'belum_bayar': 'Belum Dibayar',
    'dalam_proses': 'Dalam Proses',
    'jatuh_tempo': 'Jatuh Tempo',
  };

  static const Map<String, HistoryStatus> _statusMap = {
    'belum_dikonfirmasi': HistoryStatus.belumDikonfirmasi,
    'menunggu_pembayaran': HistoryStatus.menungguPembayaran,
    'dikonfirmasi': HistoryStatus.dikonfirmasi,
    'sedang_disewa': HistoryStatus.sedangDisewa,
    'selesai': HistoryStatus.selesai,
    'dibatalkan': HistoryStatus.dibatalkan,
    'belum_bayar': HistoryStatus.belumBayar,
    'dalam_proses': HistoryStatus.dalamProses,
    'jatuh_tempo': HistoryStatus.jatuhTempo,
  };

  static HistoryStatus fromString(String value) {
    log(value);
    return _statusMap[value]!;
  }

  String get label => _statusLabels[_value] ?? 'Status Tidak Diketahui';

  @override
  String toString() => _value;
}
