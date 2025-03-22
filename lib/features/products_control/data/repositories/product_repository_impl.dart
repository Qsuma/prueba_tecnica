import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica/core/conection/network_info.dart';
import 'package:prueba_tecnica/core/error/exceptions.dart';
import 'package:prueba_tecnica/core/error/failure.dart';
import 'package:prueba_tecnica/features/products_control/data/datasources/product_local_datasource_impl.dart';
import 'package:prueba_tecnica/features/products_control/data/datasources/product_remote_datasource.dart';
import '../../business/repositories/product_repository.dart';

import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  final ProductRemoteDataSourceImpl remoteProductDatasource;
  final NetworkInfo networkInfo;
  final ProductLocalDataSourceImpl localProductDataSource;

  ProductRepositoryImpl({
    required this.remoteProductDatasource,
    required this.networkInfo,
    required this.localProductDataSource,
  });

  @override
  Future<Either<Failure, void>> approveProduct(ProductModel product) async {
    try {
      await localProductDataSource.approveProduct(product);
      return Right(null);
    } on CacheException {
      return Left(
        CacheFailure(
          errorMessage: 'No hay productos en la base de datos local.',
        ),
      );
    } catch (e) {
      return Left(
        UnknownFailure(errorMessage: 'Error desconocido: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> createProduct(List<ProductModel> products) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      // final localProducts = await localProductDataSource.getProducts();

      if (await networkInfo.isConnected!) {
        final remoteProducts = await remoteProductDatasource.getProducts();

        // Comprobar si los productos remotos ya están en local
        // final localProductIds = localProducts.map((p) => p.id).toSet();
        //final remoteProductIds = remoteProducts.map((p) => p.id).toSet();

        // if (!localProductIds.containsAll(remoteProductIds)) {
        //   await localProductDataSource.createProducts(remoteProducts);
        // }

        return Right(remoteProducts);
      } else {
       return Left(UnknownFailure(errorMessage: 'No esta conectado'));
        //   return Right(remoteProducts); // No hay internet, usar datos locales
      }
    } on CacheException {
      return Left(
        CacheFailure(
          errorMessage: 'No hay productos en la base de datos local.',
        ),
      );
    } catch (e) {
      return Left(
        UnknownFailure(errorMessage: 'Error desconocido: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> rejectProduct(ProductModel product) async {
    try {
      await localProductDataSource.rejectProduct(product);
      return Right(null);
    } on CacheException {
      return Left(
        CacheFailure(
          errorMessage: 'No hay productos en la base de datos local.',
        ),
      );
    } catch (e) {
      return Left(
        UnknownFailure(errorMessage: 'Error desconocido: ${e.toString()}'),
      );
    }
  }
}
