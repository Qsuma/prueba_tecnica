
import 'package:prueba_tecnica/features/products_control/data/models/product_model.dart';



abstract class ProductDatasource {
  
  Future< ProductModel> approveProduct();
  Future< ProductModel> rejectProduct();
  Future< ProductModel> createProducts(List<ProductModel>products);
  Future< List<ProductModel>> getProducts();
  Future< ProductModel> updateProduct();
  Future< ProductModel> deleteProduct();



}
