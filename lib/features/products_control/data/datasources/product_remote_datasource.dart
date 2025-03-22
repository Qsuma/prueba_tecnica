import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:prueba_tecnica/core/error/exceptions.dart';
import 'package:prueba_tecnica/features/products_control/business/datasources/product_datasource.dart';
import 'package:prueba_tecnica/features/products_control/data/models/product_model.dart';

class ProductRemoteDataSourceImpl implements ProductDatasource {
  final Dio dio = Dio();
  @override
  Future<List<ProductModel>> getProducts() async {
    var options = Options(method: 'GET', headers: {'Authorization': ''});

    dio.options.contentType = 'application/json';

    dio.options.validateStatus = (status) {
      return status! < 500;
    };
    final response = await dio.get(
      'https://67dabad135c87309f52dc05a.mockapi.io/api/v1/product',
      options: options,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => ProductModel.fromMap(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> approveProduct(String id) {
    // TODO: implement approveProduct
    throw UnimplementedError();
  }

  @override
  Future<void> createProducts(List<ProductModel> products) {
    // TODO: implement createProducts
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<void> rejectProduct(String id) {
    // TODO: implement rejectProduct
    throw UnimplementedError();
  }
}
