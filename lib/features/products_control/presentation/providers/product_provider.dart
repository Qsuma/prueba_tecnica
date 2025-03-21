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

class TemplateProvider extends ChangeNotifier {
  List<ProductModel>? products;
  Failure? failure;

  TemplateProvider({this.products, this.failure});

  void eitherFailureOrProducts() async {
    ProductRepositoryImpl repository = ProductRepositoryImpl(
      remoteProductDatasource: ProductRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localProductDataSource: ProductLocalDataSourceImpl(),
    );

    final failureOrProduct =
        await GetProduct(productRepository: repository).call();

    failureOrProduct.fold(
      (Failure newFailure) {
        products = null;
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
    ProductRepositoryImpl repository = ProductRepositoryImpl(
      remoteProductDatasource: ProductRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localProductDataSource: ProductLocalDataSourceImpl(),
    );

    final failureOrProduct = await ApprobeProduct(
      productRepository: repository,
    ).call(product.id);

      failureOrProduct.fold(
      (Failure newFailure) {
        failure = newFailure;
      },
      (s) {
        final index = products!.indexWhere((element) => element.id == product.id);
        if (index != -1) {
          products![index] = product.copyWith(aprobed: true);
        }
        failure = null;
      },
    );
    notifyListeners();
  }
    void eitherFailureOrRejectProducts(ProductModel product) async {
    ProductRepositoryImpl repository = ProductRepositoryImpl(
      remoteProductDatasource: ProductRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localProductDataSource: ProductLocalDataSourceImpl(),
    );

    final failureOrProduct = await RejectProduct(
      productRepository: repository,
    ).call(product.id);

      failureOrProduct.fold(
      (Failure newFailure) {
        failure = newFailure;
      },
      (s) {
        final index = products!.indexWhere((element) => element.id == product.id);
        if (index != -1) {
          products![index] = product.copyWith(aprobed: false);
        }
        failure = null;
      },
    );
    notifyListeners();
  }
}
