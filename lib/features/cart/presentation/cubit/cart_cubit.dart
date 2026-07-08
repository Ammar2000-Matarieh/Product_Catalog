import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_with_local_cart/core/database/db_helper.dart';
import 'package:product_catalog_with_local_cart/features/products/data/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> loadCart() async {
    emit(CartLoading());
    final itemsMap = await DbHelper.instance.getCartItems();
    List<ProductModel> items = itemsMap
        .map((map) => ProductModel.fromCartMap(map))
        .toList();

    double total = 0;
    for (var item in items) {
      total += (item.price * item.quantity);
    }
    emit(CartLoaded(items, total));
  }

  Future<void> addToCart(ProductModel product) async {
    final itemsMap = await DbHelper.instance.getCartItems();
    bool exists = false;
    int currentQty = 1;

    for (var map in itemsMap) {
      if (map['id'] == product.id) {
        exists = true;
        currentQty = map['quantity'] + 1;
        break;
      }
    }

    if (exists) {
      await DbHelper.instance.updateQuantity(product.id, currentQty);
    } else {
      product.quantity = 1;
      await DbHelper.instance.addToCart(product.toCartMap());
    }
    loadCart();
  }

  Future<void> updateQuantity(int id, int qty) async {
    if (qty <= 0) {
      await DbHelper.instance.removeFromCart(id);
    } else {
      await DbHelper.instance.updateQuantity(id, qty);
    }
    loadCart();
  }

  Future<void> removeFromCart(int id) async {
    await DbHelper.instance.removeFromCart(id);
    loadCart();
  }
}
