import 'dart:convert';

class PenyewaanRequestModel {
  final int kosanId;
  final String tanggalMulai;
  final int durasiSewa;
  final int jumlahOrang;
  final int total;

  PenyewaanRequestModel({
    required this.kosanId,
    required this.tanggalMulai,
    required this.durasiSewa,
    required this.jumlahOrang,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'kosan_id': kosanId,
      'tanggal_mulai': tanggalMulai,
      'durasi_sewa': durasiSewa,
      'jumlah_orang': jumlahOrang,
      'total': total,
    };
  }

  factory PenyewaanRequestModel.fromMap(Map<String, dynamic> map) {
    return PenyewaanRequestModel(
      kosanId: map['kosanId'] as int,
      tanggalMulai: map['tanggalMulai'] as String,
      durasiSewa: map['durasiSewa'] as int,
      jumlahOrang: map['jumlah_orang'] ?? 0,
      total: map['total'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PenyewaanRequestModel.fromJson(String source) =>
      PenyewaanRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
