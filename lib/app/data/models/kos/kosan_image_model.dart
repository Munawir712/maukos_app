import 'dart:convert';

class KosanImageModel {
  int id;
  int kosanId;
  String filename;
  String imageUrl;

  KosanImageModel({
    required this.id,
    required this.kosanId,
    required this.filename,
    required this.imageUrl,
  });

  factory KosanImageModel.fromRawJson(String str) =>
      KosanImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KosanImageModel.fromJson(Map<String, dynamic> json) =>
      KosanImageModel(
        id: json["id"],
        kosanId: json["kosan_id"] is String
            ? int.parse(json["kosan_id"])
            : json["kosan_id"],
        filename: json["filename"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kosan_id": kosanId,
        "filename": filename,
        "image_url": imageUrl,
      };
}
