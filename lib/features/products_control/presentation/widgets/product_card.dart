import 'package:flutter/material.dart';
import 'package:prueba_tecnica/features/products_control/data/models/product_model.dart';
import 'package:prueba_tecnica/features/products_control/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: 200,
          width: MediaQuery.sizeOf(context).width * 0.4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagen del Producto
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no_image.png'),
                  image: product.images.isNotEmpty
                      ? NetworkImage(product.images.first)
                      : const AssetImage('assets/no_image.png') as ImageProvider,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/no_image.png'),
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(width: 12),
              // Información del producto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Opciones de aprobación y rechazo
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Checkbox para aprobar
                  Row(
                    children: [
                      Checkbox(
                        value: product.aprobed,
                        onChanged: (value) {
                          if (value == true) {
                            provider.eitherFailureOrApproveProducts(product);
                          }
                        },
                      ),
                      const Text("Aprobar"),
                    ],
                  ),
                  // Botón de rechazo: icono de basurero en rojo
                  IconButton(
                    onPressed: () {
                      provider.eitherFailureOrRejectProducts(product);
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    tooltip: 'Rechazar',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
