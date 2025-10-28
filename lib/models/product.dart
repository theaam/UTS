// lib/models/product.dart
import 'dart:convert';

// Fungsi untuk mem-parsing List<Product> dari string JSON
List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  // Factory constructor untuk membuat instance Product dari map (data JSON)
  // Ini sangat berguna untuk integrasi API di masa depan
  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    category: json["category"],
  );
}

// Item untuk keranjang, menambahkan kuantitas
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}