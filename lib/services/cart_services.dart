// lib/services/cart_service.dart
import 'package:project_uts/models/product.dart';
import 'package:flutter/material.dart';

class CartService extends ChangeNotifier {
  // Data keranjang belanja (dummy)
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  // Hitung total harga
  int get totalPrice {
    int total = 0;
    for (var item in _items) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  // Tambah item ke keranjang
  void addItem(Product product, int quantity) {
    // Cek apakah produk sudah ada di keranjang
    for (var item in _items) {
      if (item.product.id == product.id) {
        item.quantity += quantity;
        notifyListeners(); // Beri tahu widget yang mendengarkan bahwa data berubah
        return;
      }
    }
    // Jika belum ada, tambahkan sebagai item baru
    _items.add(CartItem(product: product, quantity: quantity));
    notifyListeners();
  }

  // Hapus item dari keranjang
  void removeItem(CartItem cartItem) {
    _items.remove(cartItem);
    notifyListeners();
  }

  // Kosongkan keranjang (setelah checkout)
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}