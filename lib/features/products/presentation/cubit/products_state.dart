part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => []; // استخدام Object? لضمان قبول القيم
}

class ProductsInitial extends ProductsState {}

class ProductLoading extends ProductsState {}

class ProductLoaded extends ProductsState {
  final List<ProductModel> products;

  const ProductLoaded(this.products);

  // ✨ التعديل الجوهري هنا: إخبار Equatable بمراقبة محتويات القائمة
  @override
  List<Object?> get props => [products, ...products.map((p) => p.isFavorite)];
}

class ProductError extends ProductsState {
  final String message;
  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
