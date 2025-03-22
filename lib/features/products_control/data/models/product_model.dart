import 'dart:convert';

import 'package:prueba_tecnica/features/products_control/business/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.aprobed,
    required super.images,
    required super.name,
    required super.description,

    required super.id,
  });
  ProductModel copyWith({
    bool? aprobed,
    List<String>? images,
    String? name,
    String? description,
    String? id,
  }) => ProductModel(
    aprobed: aprobed ?? this.aprobed,
    images: images ?? this.images,
    name: name ?? this.name,
    description: description ?? this.description,
    id: id ?? this.id,
  );

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
    aprobed: json["aprobed"],
    images: List<String>.from(json['images'] ?? []),
    name: json["name"],
    description: json["description"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
      
        "aprobed": aprobed.toString(),
       
        "images": images.join(','),
        "name": name,
        "description": description,
        "id": id,
      };
}
