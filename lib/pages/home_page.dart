// lib/pages/home_page.dart
import 'package:project_uts/models/product.dart';
import 'package:project_uts/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk 'rootBundle'

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // DIUBAH: Kita akan memuat dua list produk yang berbeda
  List<Product> _popularProducts = [];
  List<Product> _newProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts(); // Mengganti nama fungsi
  }

  // DIUBAH: Memuat data untuk kedua list
  Future<void> _loadProducts() async {
    try {
      // Pastikan path ini sesuai dengan nama file JSON Anda ('items.json' atau 'products.json')
      final String response =
      await rootBundle.loadString('assets/data/items.json');
      final List<Product> allProducts = productFromJson(response);

      setState(() {
        // Ambil 3 produk pertama sebagai "Populer"
        _popularProducts = allProducts.take(3).toList();

        // Ambil 3 produk berikutnya sebagai "Baru" (kita skip 2, lalu ambil 3)
        // Ini hanya untuk simulasi data yang berbeda
        if (allProducts.length > 2) {
          _newProducts = allProducts.skip(2).take(3).toList();
        } else {
          _newProducts = allProducts; // Cadangan jika data kurang
        }

        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error loading products: $e");
    }
  }

  // Helper widget untuk judul setiap bagian
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        title: Text(
          "Celeo Bakery",
          style: TextStyle(
            fontFamily: 'CreamCake', // Font kustom Anda
            color: Colors.orange.shade800,
            fontSize: 50,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined,
                color: Colors.grey.shade800),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      // Body tetap menggunakan ListView agar bisa di-scroll
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- BAGIAN 1: Welcome Text (Tetap) ---
          Text(
            "Halo, Selamat Datang!",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Temukan roti favoritmu di Celeo.",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 20),

          // --- BAGIAN 2: Search Bar (Tetap) ---
          _buildSearchBar(),
          const SizedBox(height: 24),

          // --- BAGIAN 3: Promo Banner (Tetap) ---
          _buildPromoBanner(context),
          const SizedBox(height: 24),

          // --- BAGIAN 4: Kategori (Tetap) ---
          _buildSectionTitle(context, "Kategori"),
          const SizedBox(height: 12),
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: _buildCategoryCard(
                    context, Icons.bakery_dining, "Roti", '/menu'),
              ),
              const SizedBox(width: 12),
              Flexible(
                fit: FlexFit.tight,
                child: _buildCategoryCard(
                    context, Icons.cake_outlined, "Kue", '/menu'),
              ),
              const SizedBox(width: 12),
              Flexible(
                fit: FlexFit.tight,
                child: _buildCategoryCard(context, Icons.breakfast_dining,
                    "Pastry", '/menu'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- BAGIAN 5: Pilihan Terlaris (Tetap) ---
          _buildSectionTitle(context, "Pilihan Terlaris"),
          const SizedBox(height: 12),
          // DIUBAH: Mengirim list produk yang sesuai
          _buildFeaturedProductList(_popularProducts, _isLoading),
          const SizedBox(height: 24),

          //
          // --- v v v KONTEN BARU DITAMBAHKAN DI SINI v v v ---
          //

          // --- BAGIAN 6: Kunjungi Toko Kami (BARU) ---
          _buildSectionTitle(context, "Kunjungi Toko Kami"),
          const SizedBox(height: 12),
          _buildStoreLocationCard(),
          const SizedBox(height: 24),

          // --- BAGIAN 7: Baru dari Oven (BARU) ---
          _buildSectionTitle(context, "Baru dari Oven"),
          const SizedBox(height: 12),
          // Menggunakan list produk yang berbeda
          _buildFeaturedProductList(_newProducts, _isLoading),

          // Memberi jarak di bagian paling bawah
          const SizedBox(height: 40),

          // --- ^ ^ ^ AKHIR DARI KONTEN BARU ^ ^ ^ ---
        ],
      ),
    );
  }

  // Widget untuk Search Bar
  Widget _buildSearchBar() {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Cari roti, pastry, kue...",
            icon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  // Widget untuk Promo Banner
  Widget _buildPromoBanner(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/menu');
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.asset(
              'assets/images/croissant.jpg', // Ganti dengan gambar banner jika ada
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.orange.shade100,
                  child: Center(
                      child: Icon(Icons.new_releases,
                          size: 50, color: Colors.orange.shade700)),
                );
              },
            ),
            Container(
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Promo Spesial Hari Ini",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Beli 2 Croissant Gratis 1 Donat",
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk satu kartu kategori
  Widget _buildCategoryCard(
      BuildContext context, IconData icon, String title, String routeName) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 30, color: Colors.orange.shade700),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  // DIUBAH: Widget ini sekarang menerima parameter list produk
  Widget _buildFeaturedProductList(List<Product> products, bool isLoading) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    // DIUBAH: Mengecek list produk yang dikirim
    if (products.isEmpty) {
      return const Center(child: Text("Produk akan segera hadir!"));
    }

    return SizedBox(
      height: 220, // Tinggi container untuk list horizontal
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length, // DIUBAH: Menggunakan panjang list
        itemBuilder: (context, index) {
          final product = products[index]; // DIUBAH: Menggunakan list
          return _buildFeaturedProductCard(context, product);
        },
      ),
    );
  }

  // Widget untuk satu kartu produk di list horizontal
  Widget _buildFeaturedProductCard(BuildContext context, Product product) {
    return SizedBox(
      width: 160,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(right: 12),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(product: product),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                product.imageUrl,
                height: 120,
                width: 160,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 120,
                  width: 160,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.bakery_dining,
                      color: Colors.grey, size: 40),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Rp ${product.price}",
                  style: TextStyle(color: Colors.orange.shade800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  // --- v v v WIDGET BARU DITAMBAHKAN DI SINI v v v ---
  //

  /// Widget (BARU) untuk menampilkan kartu lokasi toko
  Widget _buildStoreLocationCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Gambar placeholder. Ganti dengan gambar peta statis jika Anda punya
          Image.asset(
            'assets/images/baguette.jpg', // Anda bisa ganti ini
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 150,
                color: Colors.orange.shade100,
                child: Center(
                  child: Icon(Icons.location_on, size: 50, color: Colors.orange.shade700),
                ),
              );
            },
          ),
          // Info alamat dan tombol
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: const Text("Celeo Bakery - Pusat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: const Text("Jl. Roti Enak No. 123, Jakarta Selatan\nBuka Setiap Hari: 07.00 - 21.00", style: TextStyle(height: 1.4)),
            trailing: ElevatedButton(
              onPressed: () {
                // Fungsi dummy untuk membuka peta
              },
              child: const Text("Rute"),
            ),
          ),
          const SizedBox(height: 8), // Padding bawah
        ],
      ),
    );
  }
}