class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int ratingCount;
  bool isFavorite;
  int quantity;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
    this.isFavorite = false,
    this.quantity = 1,
  });

  ProductModel copyWith({bool? isFavorite, int? quantity}) {
    return ProductModel(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating,
      ratingCount: ratingCount,
      isFavorite: isFavorite ?? this.isFavorite,
      quantity: quantity ?? this.quantity,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      rating: json['rating'] != null
          ? (json['rating']['rate'] as num).toDouble()
          : 0.0,
      ratingCount: json['rating'] != null ? json['rating']['count'] as int : 0,
    );
  }

  Map<String, dynamic> toCartMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory ProductModel.fromCartMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: '',
      category: '',
      image: map['image'],
      rating: 0.0,
      ratingCount: 0,
      quantity: map['quantity'],
    );
  }
}
