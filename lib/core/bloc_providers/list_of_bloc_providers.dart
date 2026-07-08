import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_with_local_cart/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:product_catalog_with_local_cart/features/products/presentation/cubit/products_cubit.dart';
import 'package:nested/nested.dart';

class AppBlocs {
  static List<SingleChildWidget> get providers => [
    BlocProvider<ProductsCubit>(
      create: (context) => ProductsCubit()..fetchProducts(),
    ),
    BlocProvider<CartCubit>(create: (context) => CartCubit()..loadCart()),
  ];
}
