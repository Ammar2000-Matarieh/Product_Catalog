import 'package:flutter/material.dart';
import 'package:product_catalog_with_local_cart/features/products/presentation/widgets/custom_item_details.dart';
import '../../data/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: CustomItemDetails(product: product),
      ),
    );
  }
}
