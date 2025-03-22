import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/features/products_control/presentation/providers/product_provider.dart';
import 'package:prueba_tecnica/features/products_control/presentation/screens/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider <ProductProvider>(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
         
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: const ProductsToReviewScreen(),
      ),
    );
  }
}
