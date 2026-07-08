import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_with_local_cart/features/cart/presentation/pages/cart_screen.dart';
import 'package:product_catalog_with_local_cart/features/home/presentation/widgets/custom_body.dart';
import 'package:product_catalog_with_local_cart/features/cart/presentation/cubit/cart_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Catalog",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 22,
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  int cartItemsCount = 0;

                  if (state is CartLoaded) {
                    cartItemsCount = state.cartItems.fold(
                      0,
                      (sum, item) => sum + item.quantity,
                    );
                  }

                  return Badge(
                    label: Text(
                      '$cartItemsCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.red,
                    isLabelVisible: cartItemsCount > 0,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: const CustomBody(),
    );
  }
}
