import 'package:prueba_tecnica/core/error/exceptions.dart';
import 'package:prueba_tecnica/core/local_database/product_database.dart';
import 'package:prueba_tecnica/features/products_control/business/datasources/product_datasource.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product_model.dart';

class ProductLocalDataSourceImpl implements ProductDatasource {
  final ProductDatabase productDatabase = ProductDatabase();

  @override
  Future<void> deleteProduct(String id) async {
    try {
      final db = await productDatabase.database;
      await db.delete('products', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> createProducts(List<ProductModel> products) async {
    final db = await productDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    if (maps.isEmpty) {
      try {
        await Future.wait(
          products.map((product) async {
            await db.insert(
              'products',
              product.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }),
        );
      } catch (e) {
        throw CacheException();
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final db = await productDatabase.database;
      final List<Map<String, dynamic>> maps = await db.query('products');

      if (maps.isNotEmpty) {
        return maps.map((map) => ProductModel.fromMap(map)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> rejectProduct(ProductModel product) async {
    await _insertProductWithApprovalStatus(product, false);
  }

  @override
  Future<void> approveProduct(ProductModel product) async {
    await _insertProductWithApprovalStatus(product, true);
  }

  Future<void> _insertProductWithApprovalStatus(
    ProductModel product,
    bool isApproved,
  ) async {
    try {
      final db = await productDatabase.database;
   

      await db.insert(
        'products',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw CacheException();
    }
  }
}
