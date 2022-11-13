// import 'package:firebase_database/firebase_database.dart';

// class Barang {
//   final String? key;
//   String? Deskripsi;
//   bool? Gambar;
//   String? Harga;
//   String? Kategori;
//   String? nama_produk;

//   Barang(
//       {this.key,
//       this.Deskripsi,
//       this.Gambar,
//       this.Harga,
//       this.Kategori,
//       this.nama_produk});

//   Barang.fromSnapshot(DataSnapshot snapshot): key = snapshot.key, //proses sending data ke realtime database
//         Deskripsi = snapshot.value!('Deskripsi'),
//         Gambar = snapshot.value!['Gambar'],
//         Harga = snapshot.value!['Harga'],
//         Kategori = snapshot.value!['Kategori'],
//         nama_produk = snapshot.value!['nama_produk'];

//   Map<String, dynamic> toJson() => {
//         //agar data dapat di baca dari bentuk Array ke bentuk JSON, karena flutter
//         'Deskripsi': Deskripsi, //hanya dapat membaca data dalam bentuk JSON
//         'Gambar': Gambar,
//         'Harga': Harga,
//         'Kategori': Kategori,
//         'nama_produk': nama_produk,
//       };
// }
