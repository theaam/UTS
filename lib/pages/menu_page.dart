// lib/pages/menu_page.dart
import 'package:project_uts/models/product.dart';
import 'package:project_uts/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk 'rootBundle'

// Ini adalah StatefulWidget karena kita perlu me-load data dari JSON
// dan menyimpannya dalam 'state'
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Product> _products = [];
  bool _isLoading = true;

  // Panggil fungsi load data saat widget pertama kali dibuat
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // Fungsi async untuk membaca file JSON lokal
  Future<void> _loadProducts() async {
    try {
      // Membaca string JSON dari file aset
      final String response =
      await rootBundle.loadString('assets/data/items.json');
      // Mengubah string JSON menjadi List<Product>
      final List<Product> data = productFromJson(response);

      // Update state dengan data yang sudah di-load
      setState(() {
        _products = data;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error jika file tidak ditemukan atau format JSON salah
      setState(() {
        _isLoading = false;
      });
      print("Error loading products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Roti Celeo"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
          child: CircularProgressIndicator(color: Colors.orange))
      // Penggunaan Widget GridView.builder untuk tampilan menu
          : GridView.builder(
        padding: const EdgeInsets.all(12),
        // Konfigurasi grid: 2 kolom
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8, // Rasio aspek item
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          // Menggunakan widget Card kustom untuk setiap item
          return _buildProductCard(context, product);
        },
      ),
    );
  }

  // Widget terpisah untuk kartu produk
  Widget _buildProductCard(BuildContext context, Product product) {
    // Penggunaan Widget Card
    return Card(
      clipBehavior: Clip.antiAlias, // Untuk memotong gambar agar sesuai radius
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: InkWell(
        onTap: () {
          // Navigasi menggunakan MaterialPageRoute
          // Ini memungkinkan kita mengirim objek 'product' ke halaman berikutnya
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Penggunaan Widget Expanded agar gambar mengisi ruang
            Expanded(
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                // Error handler jika gambar tidak ditemukan
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                      child: Icon(Icons.broken_image,
                          color: Colors.grey, size: 40));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Rp ${product.price}",
                style: TextStyle(
                    fontSize: 14, color: Colors.orange.shade800),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}