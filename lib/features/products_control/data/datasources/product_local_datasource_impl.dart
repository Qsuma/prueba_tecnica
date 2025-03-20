import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica/core/error/exceptions.dart';
import 'package:prueba_tecnica/core/error/failure.dart';
import 'package:prueba_tecnica/core/local_database/product_database.dart';
import 'package:prueba_tecnica/features/products_control/business/datasources/product_datasource.dart';
import 'package:prueba_tecnica/features/products_control/business/entities/product_entity.dart';
import 'package:prueba_tecnica/features/products_control/business/repositories/product_repository.dart';
import 'package:prueba_tecnica/features/products_control/data/datasources/template_local_data_source.dart';

import '../models/product_model.dart';

class ProductLocalDataSourceImpl implements ProductDatasource {
  ProductDatabase productDatabase = ProductDatabase();

  ProductLocalDataSourceImpl();

  @override
  Future<void> cacheProducts({required TemplateModel? templateToCache}) async {}

  @override
  Future<ProductModel> approveProduct() {
    // TODO: implement approveProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> deleteProduct() {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> createProducts() {
    if (templateToCache != null) {
      sharedPreferences.setString(
        cachedTemplate,
        json.encode(templateToCache.toJson()),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final db = await productDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    if (maps.isNotEmpty) {
      return maps.map((map) => ProductModel.fromMap(map)).toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> rejectProduct() {
    // TODO: implement rejectProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> updateProduct() {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
