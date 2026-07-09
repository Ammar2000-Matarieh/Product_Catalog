import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_with_local_cart/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:product_catalog_with_local_cart/features/products/data/models/product_model.dart';

class CustomItemCard extends StatelessWidget {
  const CustomItemCard({super.key, required this.item});

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(item.image, width: 50, fit: BoxFit.contain),
        title: Text(
          item.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("\$${item.price} x ${item.quantity}"),
            Text(
              "Subtotal: \$${(item.price * item.quantity).toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () => context.read<CartCubit>().updateQuantity(
                item.id,
                item.quantity - 1,
              ),
            ),
            Text("${item.quantity}"),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => context.read<CartCubit>().updateQuantity(
                item.id,
                item.quantity + 1,
              ),
            ),

            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () =>
                  context.read<CartCubit>().removeFromCart(item.id),
            ),
          ],
        ),
      ),
    );
  }
}
