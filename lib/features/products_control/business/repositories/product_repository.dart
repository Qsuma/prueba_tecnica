import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica/core/error/failure.dart';
import 'package:prueba_tecnica/features/products_control/business/datasources/product_datasource.dart';
import 'package:prueba_tecnica/features/products_control/data/models/product_model.dart';

abstract class ProductRepository {
  final ProductDatasource remoteProductDatasource;

  ProductRepository({required this.remoteProductDatasource});
  Future<Either<Failure, void>> approveProduct(String id);
  Future<Either<Failure, void>> rejectProduct(String id);
  Future<Either<Failure, void>> createProduct(
    List<ProductModel> products,
  );
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, void>> deleteProduct(String id);
}
