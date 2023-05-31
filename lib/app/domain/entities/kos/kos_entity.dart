import 'package:equatable/equatable.dart';

class KosEntity extends Equatable {
  final int kosId;
  final String numberKos;
  final String name;
  final String description;
  final String address;
  final String type;
  final String genderCategory;
  final String status;
  final int price;
  final List<String> imagesPaths;

  const KosEntity({
    required this.kosId,
    required this.numberKos,
    required this.name,
    required this.description,
    required this.address,
    required this.type,
    required this.genderCategory,
    required this.status,
    required this.price,
    required this.imagesPaths,
  });
  @override
  List<Object?> get props => [
        kosId,
        numberKos,
        name,
        description,
        address,
        type,
        genderCategory,
        price,
        imagesPaths
      ];
}

List<KosEntity> listKos = const [
  KosEntity(
    kosId: 1,
    numberKos: '001',
    name: 'Kos Putri',
    description: 'ini adalah kos putri',
    address: 'Banda Aceh Kuta Kos',
    type: 'KAMAR',
    genderCategory: 'PUTRI',
    price: 500000,
    status: 'TERSEDIA',
    imagesPaths: [
      "https://images.unsplash.com/photo-1572120360610-d971b9d7767c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
      "https://images.unsplash.com/photo-1480074568708-e7b720bb3f09?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGhvdXNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    ],
  ),
];
