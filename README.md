# 🍰 Celeo - Toko Roti Flutter App

**Celeo** adalah aplikasi mobile berbasis **Flutter** yang dirancang untuk menampilkan daftar produk roti, detail produk, dan fitur keranjang belanja sederhana.  
Aplikasi ini dibuat sebagai proyek **UTS Mobile Programming**.

---

## 🚀 Fitur Utama

-  **Halaman Home** — Menampilkan daftar produk roti dari data JSON lokal  
-  **Halaman Detail Produk** — Menampilkan informasi detail setiap produk  
-  **Halaman Keranjang (Cart)** — Menambahkan dan menghapus produk yang dipilih  
-  **Data Lokal (Offline)** — Menggunakan file JSON (`assets/data/items.json`) sebagai sumber data  
-  **UI Menarik dan Responsif** — Desain modern dan mudah digunakan  

---

## 🧱 Struktur Folder
<img width="150" height="500" alt="Screenshot 2025-10-28 213754" src="https://github.com/user-attachments/assets/2aa721da-0201-4c4f-8956-fe302d5a8246" />
project_uts/
├── assets/
│ ├── data/
│ │ └── items.json
│ └── images/
│ ├── baguette.jpg
│ ├── croissant.jpg
│ ├── donut.jpg
│ └── gandum.jpg
├── lib/
│ ├── main.dart
│ ├── models/
│ │ └── product.dart
│ ├── pages/
│ │ ├── home_page.dart
│ │ ├── menu_page.dart
│ │ ├── detail_page.dart
│ │ └── cart_page.dart
│ └── services/
│ └── cart_services.dart
├── fonts/
│ └── CreamCake.otf
└── pubspec.yaml

