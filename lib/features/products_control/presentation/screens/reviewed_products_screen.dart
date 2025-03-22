import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/features/products_control/presentation/providers/product_provider.dart';
import '../widgets/reviewed_product_card.dart';

class ReviewedProductsScreen extends StatefulWidget {
  const ReviewedProductsScreen({super.key});

  @override
  State<ReviewedProductsScreen> createState() => _ReviewedProductsScreenState();
}

class _ReviewedProductsScreenState extends State<ReviewedProductsScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _itemsPerPage = 7;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final reviewedProducts = provider.products
        ?.where((product) => product.aprobed != null)
        .toList();

    final paginatedProducts = reviewedProducts
            ?.skip((_currentPage - 1) * _itemsPerPage)
            .take(_itemsPerPage)
            .toList() ??
        [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos Revisados'),
      ),
      body: reviewedProducts == null || reviewedProducts.isEmpty
          ? const Center(child: Text('No hay productos revisados'))
          : ListView.builder(
              controller: _scrollController,
              itemCount: paginatedProducts.length + 1,
              itemBuilder: (context, index) {
                if (index < paginatedProducts.length) {
                  final product = paginatedProducts[index];
                  return ReviewedProductCard(product: product);
                } else {
                  return _currentPage * _itemsPerPage < reviewedProducts.length
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox();
                }
              },
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
