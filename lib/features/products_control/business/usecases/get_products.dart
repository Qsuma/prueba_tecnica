import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica/core/error/failure.dart';

import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProduct {
 
  final ProductRepository productRepository;

  GetProduct({ required this.productRepository});

  

  Future<Either<Failure, ProductEntity>> call() async {
    return await productRepository.getProduct();
  }
}
