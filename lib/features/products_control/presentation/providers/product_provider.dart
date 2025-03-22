import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:prueba_tecnica/core/conection/network_info.dart';
import 'package:prueba_tecnica/core/error/failure.dart';
import 'package:prueba_tecnica/features/products_control/business/usecases/approve_product.dart';
import 'package:prueba_tecnica/features/products_control/business/usecases/get_products.dart';
import 'package:prueba_tecnica/features/products_control/data/datasources/product_local_datasource_impl.dart';
import 'package:prueba_tecnica/features/products_control/data/datasources/product_remote_datasource.dart';
import 'package:prueba_tecnica/features/products_control/data/models/product_model.dart';
import '../../business/usecases/reject_product.dart';
import '../../data/repositories/product_repository_impl.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> products = [];
  List<ProductModel> reviewedproducts = [];
  Failure? failure;

  ProductProvider() {
    eitherFailureOrProducts();
  }

  void eitherFailureOrProducts() async {
    final repository = ProductRepositoryImpl(
      remoteProductDatasource: ProductRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localProductDataSource: ProductLocalDataSourceImpl(),
    );

    final failureOrProduct =
        await GetProduct(productRepository: repository).call();

    failureOrProduct.fold(
      (Failure newFailure) {
        products = [];
        failure = newFailure;
        notifyListeners();
      },
      (List<ProductModel> newProducts) {
        products = newProducts;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrApproveProducts(ProductModel product) async {
    final repository = ProductRepositoryImpl(
      remoteProductDatasource: ProductRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localProductDataSource: ProductLocalDataSourceImpl(),
    );

    final failureOrResult = await ApprobeProduct(
      productRepository: repository,
    ).call(product);

    failureOrResult.fold(
      (Failure newFailure) {
        failure = newFailure;
      },
      (result) {
        final updatedProduct = product.copyWith(aprobed: true);

        reviewedproducts.add(updatedProduct);
       
        products.removeWhere((p) => p.id == product.id);
        failure = null;
      },
    );
    notifyListeners();
  }

  void eitherFailureOrRejectProducts(ProductModel product) async {
    final repository = ProductRepositoryImpl(
      remoteProductDatasource: ProductRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localProductDataSource: ProductLocalDataSourceImpl(),
    );

    final failureOrResult = await RejectProduct(
      productRepository: repository,
    ).call(product);

    failureOrResult.fold(
      (Failure newFailure) {
        failure = newFailure;
      },
      (result) {
        final updatedProduct = product.copyWith(aprobed: false);

        reviewedproducts.add(updatedProduct);

        products.removeWhere((p) => p.id == product.id);
        failure = null;
      },
    );
    notifyListeners();
  }
}
