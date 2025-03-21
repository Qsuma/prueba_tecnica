import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica/core/error/failure.dart';
import 'package:prueba_tecnica/features/products_control/data/models/product_model.dart';

import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProduct {
 
  final ProductRepository productRepository;

  GetProduct({ required this.productRepository});

  

  Future<Either<Failure, List<ProductModel>>> call() async {
    return await productRepository.getProducts();
  }
}
