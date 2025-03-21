import 'dart:convert';

import 'package:prueba_tecnica/features/products_control/business/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.aprobed,
    required super.images,
    required super.name,
    required super.description,
    required super.price,
    required super.id,
  });
  ProductModel copyWith({
    bool? aprobed,
    List<String>? images,
    String? name,
    String? description,
    double? price,
    String? id,
  }) => ProductModel(
    aprobed: aprobed ?? this.aprobed,
    images: images ?? this.images,
    name: name ?? this.name,
    description: description ?? this.description,
    price: price ?? this.price,
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
    price: json["price"]?.toDouble(),
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "aprobed": aprobed,
    "images": List<dynamic>.from(images.map((x) => x)),
    "name": name,
    "description": description,
    "price": price,
    "id": id,
  };
}
