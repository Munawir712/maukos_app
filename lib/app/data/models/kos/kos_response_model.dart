import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:maukos_app/app/domain/entities/kos/kos_entity.dart';

import 'facilities_model.dart';
import 'kosan_image_model.dart';

class KosResponseModel extends Equatable {
  final int id;
  final String noKamar;
  final String name;
  final String alamat;
  final String latitude;
  final String longitude;
  final String category;
  final String tipe;
  final String genderCategory;
  final String? description;
  final int harga;
  final int maxOrang;
  final int jumlahKos;
  final int jumlahDisewa;
  final List<KosanImageModel> kosanImage;
  final List<FacilityModel> facilities;
  final String status;

  const KosResponseModel({
    required this.id,
    required this.noKamar,
    required this.name,
    required this.alamat,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.tipe,
    required this.genderCategory,
    this.description,
    required this.harga,
    required this.maxOrang,
    required this.jumlahKos,
    required this.jumlahDisewa,
    required this.kosanImage,
    required this.facilities,
    required this.status,
  });

  factory KosResponseModel.fromRawJson(String str) =>
      KosResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KosResponseModel.fromJson(Map<String, dynamic> json) =>
      KosResponseModel(
        id: json["id"] ?? 0,
        noKamar: json["no_kamar"] ?? '',
        name: json["name"] ?? '',
        alamat: json["alamat"] ?? '',
        latitude: json['latitude'] ?? '',
        longitude: json['longitude'] ?? '',
        category: json["category"] ?? '',
        tipe: json["tipe"] ?? '',
        genderCategory: json["gender_category"] ?? '',
        description: json['description'] ?? '',
        harga: json["harga"] != null
            ? json["harga"] is String
                ? int.parse(json["harga"])
                : json["harga"]
            : 0,
        maxOrang: json['max_orang'] != null
            ? json['max_orang'] is String
                ? int.parse(json['max_orang'])
                : json['max_orang']
            : 0,
        jumlahKos: json['jumlah_kos'] != null
            ? json['jumlah_kos'] is String
                ? int.parse(json['jumlah_kos'])
                : json['jumlah_kos']
            : 0,
        jumlahDisewa: json['jumlah_disewa'] != null
            ? json['jumlah_disewa'] is String
                ? int.parse(json['jumlah_disewa'])
                : json['jumlah_disewa']
            : 0,
        status: json["status"] ?? '',
        kosanImage: json["kosan_image"] != null
            ? List<KosanImageModel>.from(
                json["kosan_image"]
                    .map((kosImage) => KosanImageModel.fromJson(kosImage)),
              )
            : [],
        facilities: json["facilities"] != null
            ? List<FacilityModel>.from(
                json["facilities"]
                    .map((facility) => FacilityModel.fromJson(facility)),
              )
            : <FacilityModel>[],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no_kamar": noKamar,
        "name": name,
        "alamat": alamat,
        "latitude": latitude,
        "longitude": longitude,
        "category": category,
        "tipe": tipe,
        "kategori_jk": genderCategory,
        'description': description,
        "harga": harga,
        "max_orang": maxOrang,
        "jumlah_kos": jumlahKos,
        "jumlah_disewa": jumlahDisewa,
        "kosan_image": List<dynamic>.from(kosanImage.map((x) => x.toJson())),
        "facilities": List<dynamic>.from(facilities.map((x) => x.toJson())),
      };

  KosEntity toEntity() => KosEntity(
        kosId: id,
        numberKos: noKamar,
        name: name,
        description: description ?? '',
        address: alamat,
        latitude: latitude,
        longitude: longitude,
        type: tipe,
        category: category,
        genderCategory: genderCategory,
        status: status,
        price: harga,
        maxPeople: maxOrang,
        amountKos: jumlahKos,
        amountRented: jumlahDisewa,
        imagesPaths: kosanImage.map((e) => e.imageUrl).toList(),
        facilities: facilities,
      );

  @override
  List<Object?> get props => [
        id,
        noKamar,
        name,
        alamat,
        latitude,
        longitude,
        category,
        tipe,
        genderCategory,
        harga,
        kosanImage,
        facilities,
        maxOrang,
        jumlahKos,
        jumlahDisewa,
      ];
}
