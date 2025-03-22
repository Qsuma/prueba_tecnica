import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica/core/error/failure.dart';
import 'package:prueba_tecnica/features/products_control/data/models/product_model.dart';
import '../repositories/product_repository.dart';

class GetLocalProduct {
 
  final ProductRepository productRepository;

  GetLocalProduct({ required this.productRepository});

  

  Future<Either<Failure, List<ProductModel>>> call() async {
    return await productRepository.getProducts();
  }
}
