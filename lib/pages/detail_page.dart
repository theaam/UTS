// lib/pages/detail_page.dart
import 'package:project_uts/models/product.dart';
import 'package:project_uts/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  // Menerima data produk dari halaman Menu
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // State untuk menyimpan jumlah kuantitas
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
    // Ambil CartService menggunakan Provider
    final cartService = Provider.of<CartService>(context, listen: false);
    cartService.addItem(widget.product, _quantity);

    // Tampilkan notifikasi (Snackbar)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "${_quantity}x ${widget.product.name} ditambahkan ke keranjang!"),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );

    // Kembali ke halaman menu
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Gambar Produk
          Hero(
            tag: widget.product.id, // Untuk animasi (opsional)
            child: Image.asset(
              widget.product.imageUrl,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 300,
                  color: Colors.grey.shade200,
                  child: const Center(
                      child: Icon(Icons.bakery_dining,
                          color: Colors.grey, size: 80)),
                );
              },
            ),
          ),

          // 2. Info Produk
          // Penggunaan Widget Flexible agar deskripsi bisa di-scroll
          // jika kontennya terlalu panjang di layar kecil.
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Rp ${widget.product.price}",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Deskripsi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ),

          // Penggunaan Widget Spacer untuk mendorong widget di bawahnya
          // ke bagian paling bawah layar.
          const Spacer(),

          // 3. Tombol Aksi (Bagian Bawah)
          _buildBottomActionSheet(),
        ],
      ),
    );
  }

  // Widget untuk bagian bawah (Kuantitas dan Tombol)
  Widget _buildBottomActionSheet() {
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
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Penggunaan Widget Row untuk mengatur kuantitas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Kuantitas:", style: TextStyle(fontSize: 18)),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: _decrementQuantity,
                    color: Colors.orange,
                  ),
                  Text("$_quantity",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _incrementQuantity,
                    color: Colors.orange,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          // Tombol untuk menambah ke keranjang
          ElevatedButton(
            onPressed: _addToCart,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              "Tambah ke Keranjang",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}