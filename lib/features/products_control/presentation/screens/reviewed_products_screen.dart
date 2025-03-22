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
  List<dynamic> _displayedProducts = [];
  int _currentPage = 0;
  final int _itemsPerPage = 7;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadMoreProducts();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoading) {
      _loadMoreProducts();
    }
  }

  void _loadMoreProducts() {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    final reviewedProducts = provider.reviewedproducts;

    if (_isLoading || _displayedProducts.length >= reviewedProducts.length)
      return;

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      final nextProducts =
          reviewedProducts
              .skip(_currentPage * _itemsPerPage)
              .take(_itemsPerPage)
              .toList();

      setState(() {
        _displayedProducts.addAll(nextProducts);
        _currentPage++;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos Revisados')),
      body:
          _displayedProducts.isEmpty
              ? const Center(child: Text('No hay productos revisados'))
              : ListView.builder(
                controller: _scrollController,
                itemCount: _displayedProducts.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < _displayedProducts.length) {
                    final product = _displayedProducts[index];
                    return ReviewedProductCard(product: product);
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
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
