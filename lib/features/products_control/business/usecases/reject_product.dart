import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica/core/error/failure.dart';
import 'package:prueba_tecnica/features/products_control/data/models/product_model.dart';
import '../repositories/product_repository.dart';

class RejectProduct {
 
  final ProductRepository productRepository;

  RejectProduct({ required this.productRepository});

  

  Future<Either<Failure, void>> call(ProductModel product) async {
    return await productRepository.rejectProduct(product);
  }
}
