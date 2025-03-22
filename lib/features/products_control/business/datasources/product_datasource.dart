
import 'package:prueba_tecnica/features/products_control/data/models/product_model.dart';



abstract class ProductDatasource {
  
  Future< void> approveProduct(ProductModel product);
  Future< void> rejectProduct(ProductModel product);
  Future<void> createProducts(List<ProductModel>products);
  Future< List<ProductModel>> getProducts();
  Future<void> deleteProduct(String id);



}
