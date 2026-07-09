import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_with_local_cart/core/bloc_providers/list_of_bloc_providers.dart';
import 'package:product_catalog_with_local_cart/features/cart/presentation/screens/cart_screen.dart';
import 'package:product_catalog_with_local_cart/features/home/presentation/screens/home_screen.dart';
import 'package:product_catalog_with_local_cart/features/products/data/models/product_model.dart';
import 'package:product_catalog_with_local_cart/features/products/presentation/screens/product_details_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocs.providers,
      child: MaterialApp(
        title: 'Product Catalog',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),

        initialRoute: '/',

        routes: {
          '/': (context) => const HomeScreen(),

          '/details': (context) {
            final product =
                ModalRoute.of(context)!.settings.arguments as ProductModel;

            return ProductDetailScreen(product: product);
          },

          '/cart': (context) => const CartScreen(),
        },
      ),
    );
  }
}
