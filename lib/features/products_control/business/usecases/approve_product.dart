import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica/core/error/failure.dart';
import 'package:prueba_tecnica/features/products_control/data/models/product_model.dart';

import '../repositories/product_repository.dart';

class ApprobeProduct {
  final ProductRepository productRepository;

  ApprobeProduct({required this.productRepository});

  Future<Either<Failure, void>> call(ProductModel product) async {
    return await productRepository.approveProduct(product);
  }
}
