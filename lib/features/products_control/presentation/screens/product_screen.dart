import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/features/products_control/presentation/providers/product_provider.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/product_card.dart';
import 'reviewed_products_screen.dart'; // Importa la nueva pantalla

class ProductsToReviewScreen extends StatelessWidget {
  const ProductsToReviewScreen({super.key});

  void _navigateToReviewedProducts(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ReviewedProductsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Desliza de derecha a izquierda
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

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
      drawer: MenuDrawer(),
      body: provider.products == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.products!.length,
              itemBuilder: (context, index) {
                final product = provider.products![index];
                return ProductCard(product: product);
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Por Revisar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Revisados',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            _navigateToReviewedProducts(context);
          }
        },
      ),
    );
  }
}

