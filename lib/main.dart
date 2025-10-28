// lib/main.dart
import 'package:project_uts/pages/cart_page.dart';
import 'package:project_uts/pages/home_page.dart';
import 'package:project_uts/pages/menu_page.dart';
import 'package:project_uts/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Impor provider

void main() {
  // Kita bungkus App dengan ChangeNotifierProvider
  // agar CartService bisa diakses dari halaman manapun
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartService(),
      child: const CeleoBakeryApp(),
    ),
  );
}

class CeleoBakeryApp extends StatelessWidget {
  const CeleoBakeryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Celeo Bakery',
      theme: ThemeData(
        // Tema warna dasar UI: orange
        primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,

      // Sistem Navigasi Routes
      // Ini adalah rute utama aplikasi
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/menu': (context) => const MenuPage(),
        '/cart': (context) => const CartPage(),
        // Halaman Detail tidak ada di sini karena kita akan memanggilnya
        // menggunakan MaterialPageRoute agar bisa mengirim data (objek Product)
      },
    );
  }
}