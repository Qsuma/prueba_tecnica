import 'package:flutter/material.dart';
import '../../business/entities/product_entity.dart';
import '../widgets/product_card.dart';

class ProductsToReviewScreen extends StatelessWidget {
  const ProductsToReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TemplateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos por Revisar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              provider.eitherFailureOrProducts();
            },
          ),
        ],
      ),
      body: provider.products == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.products!.length,
              itemBuilder: (context, index) {
                final product = provider.products![index];
                return ProductCard(product: product);
              },
            ),
    );
  }
}
