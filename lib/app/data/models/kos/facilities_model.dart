import 'dart:convert';

class FacilityModel {
  int id;
  String name;
  String slug;
  String desc;

  FacilityModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.desc,
  });

  factory FacilityModel.fromRawJson(String str) =>
      FacilityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FacilityModel.fromJson(Map<String, dynamic> json) => FacilityModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "desc": desc,
      };
}
