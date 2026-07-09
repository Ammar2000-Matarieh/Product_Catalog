import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_with_local_cart/core/widgets/custom_button.dart';
import 'package:product_catalog_with_local_cart/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:product_catalog_with_local_cart/features/products/data/models/product_model.dart';

class CustomItemDetails extends StatelessWidget {
  const CustomItemDetails({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: CachedNetworkImage(
            imageUrl: product.image,
            height: 250,
            fit: BoxFit.contain,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image, size: 100),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          product.title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "\$${product.price}",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Chip(label: Text(product.category)),
        const SizedBox(height: 10),

        Row(
          children: [
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < product.rating.floor()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                );
              }),
            ),
            const SizedBox(width: 8),
            Text("${product.rating} (${product.ratingCount} reviews)"),
          ],
        ),

        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          // margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Text(
            product.description,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
        const SizedBox(height: 30),

        CustomButton(
          onPressed: () {
            context.read<CartCubit>().addToCart(product);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Added to Cart!")));
          },
          backgroundColor: Colors.blue,
          child: const Text(
            "Add to Cart",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
