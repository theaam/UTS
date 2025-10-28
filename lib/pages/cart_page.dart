// lib/pages/cart_page.dart
import 'package:project_uts/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan 'Consumer' agar widget ini otomatis di-build ulang
    // setiap kali CartService memanggil 'notifyListeners()'
    return Consumer<CartService>(
      builder: (context, cartService, child) {
        final cartItems = cartService.items;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Keranjang Saya"),
          ),
          body: cartItems.isEmpty
              ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined,
                    size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text("Keranjang Anda kosong",
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ],
            ),
          )
          // Penggunaan Column dan Expanded
              : Column(
            children: [
              // Penggunaan Widget Expanded agar ListView
              // mengisi semua ruang yang tersedia
              Expanded(
                // Penggunaan Widget ListView.builder
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    // Tampilan item keranjang
                    return ListTile(
                      leading: Image.asset(
                        item.product.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.product.name),
                      subtitle: Text(
                          "${item.quantity}x @ Rp ${item.product.price}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          cartService.removeItem(item);
                        },
                      ),
                    );
                  },
                ),
              ),

              // Bagian Total dan Checkout (Tetap di bawah)
              _buildCheckoutSection(context, cartService),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCheckoutSection(
      BuildContext context, CartService cartService) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Penggunaan Row untuk Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Harga:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                "Rp ${cartService.totalPrice}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade800),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Fungsi Checkout (dummy)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Checkout berhasil! (Dummy)"),
                    backgroundColor: Colors.blue),
              );
              cartService.clearCart();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("Checkout", style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}