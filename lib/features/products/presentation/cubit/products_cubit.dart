import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_catalog_with_local_cart/core/constants/api_constants.dart';
import 'package:product_catalog_with_local_cart/core/errors/api_failure.dart';
import 'package:product_catalog_with_local_cart/features/products/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final Dio _dio = Dio();
  List<ProductModel> _allProducts = [];

  ProductsCubit() : super(ProductsInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final response = await _dio.get(
        ApiConstants.baseUrl + ApiConstants.endpointProducts,
      );

      final prfes = await SharedPreferences.getInstance();
      final List<String> favIds = prfes.getStringList('favorites') ?? [];

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        _allProducts = data.map((json) => ProductModel.fromJson(json)).toList();

        for (var product in _allProducts) {
          if (favIds.contains(product.id.toString())) {
            product.isFavorite = true;
          }
        }
        emit(ProductLoaded(_allProducts));
      } else {
        emit(const ProductError("Failed to fetch data from server"));
      }
    } on DioException catch (e) {
      final failure = ApiFailure.fromDioException(e);
      emit(ProductError(failure.message));
    } catch (e) {
      emit(ProductError("Unexpected error occurred: ${e.toString()}"));
    }
  }

  void toggleFavorite(int id) async {
    final prfes = await SharedPreferences.getInstance();
    final List<String> favIds = prfes.getStringList('favorites') ?? [];

    _allProducts = _allProducts.map((product) {
      if (product.id == id) {
        final newFavStatus = !product.isFavorite;

        if (newFavStatus) {
          if (!favIds.contains(id.toString())) favIds.add(id.toString());
        } else {
          favIds.remove(id.toString());
        }

        return product.copyWith(isFavorite: newFavStatus);
      }
      return product;
    }).toList();

    await prfes.setStringList('favorites', favIds);

    emit(ProductLoaded(List.from(_allProducts)));
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      emit(ProductLoaded(_allProducts));
    } else {
      final filtered = _allProducts
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ProductLoaded(filtered));
    }
  }
}
