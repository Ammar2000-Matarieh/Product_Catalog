import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_with_local_cart/core/widgets/custom_text_field.dart';
import 'package:product_catalog_with_local_cart/features/home/presentation/widgets/custom_item.dart';
import 'package:product_catalog_with_local_cart/features/products/presentation/cubit/products_cubit.dart';

class CustomBody extends StatelessWidget {
  const CustomBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            labelText: "Search Products...",
            onChanged: (val) =>
                context.read<ProductsCubit>().searchProducts(val),
          ),
        ),
        Expanded(
          child: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProductError) {
                return Center(child: Text(state.message));
              }
              if (state is ProductLoaded) {
                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<ProductsCubit>().fetchProducts(),
                  child: CustomItem(products: state.products),
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
