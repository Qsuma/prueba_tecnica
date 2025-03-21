import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica/core/error/failure.dart';

import '../repositories/product_repository.dart';

class ApprobeProduct {
  final ProductRepository productRepository;

  ApprobeProduct({required this.productRepository});

  Future<Either<Failure, void>> call(String id) async {
    return await productRepository.approveProduct(id);
  }
}
