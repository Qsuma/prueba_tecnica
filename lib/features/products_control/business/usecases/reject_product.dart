import 'package:dartz/dartz.dart';
import 'package:prueba_tecnica/core/error/failure.dart';
import '../repositories/product_repository.dart';

class RejectProduct {
 
  final ProductRepository productRepository;

  RejectProduct({ required this.productRepository});

  

  Future<Either<Failure, void>> call(String id) async {
    return await productRepository.rejectProduct(id);
  }
}
