import 'package:flutter/material.dart';
import 'package:prueba_tecnica/features/products_control/data/models/product_model.dart';

class ReviewedProductCard extends StatelessWidget {
  final ProductModel product;

  const ReviewedProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    bool isApproved = product.aprobed == true;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage(
            placeholder: const AssetImage('assets/no_image.png'),
            image: product.images.isNotEmpty
                ? NetworkImage(product.images.first)
                : const AssetImage('assets/no_image.png') as ImageProvider,
            imageErrorBuilder: (context, error, stackTrace) =>
                Image.asset('assets/no_image.png'),
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(product.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(product.description ?? 'Sin descripción'),
        trailing: Chip(
          label: Text(isApproved ? 'Aprobado' : 'Rechazado'),
          backgroundColor: isApproved ? Colors.green : Colors.red,
          labelStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
