import 'package:flutter/material.dart';

void main() {
  runApp(const BukuApp());
}

class BukuApp extends StatelessWidget {
  const BukuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Buku Perpustakaan Mini',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CatalogPage(),
    );
  }
}

String kategoriRating(double rating) {
  if (rating >= 4.5) {
    return 'Sangat Baik';
  } else if (rating >= 3.5) {
    return 'Baik';
  } else {
    return 'Cukup';
  }
}

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final List<Map<String, dynamic>> _bukuList = [
    {
      'judul': 'Laskar Pelangi',
      'pengarang': 'Andrea Hirata',
      'tahunTerbit': 2005,
      'rating': 4.8,
      'tersedia': true,
      'genre': 'Novel',
      'catatanPeminjam': 'Kondisi buku masih sangat rapi.',
    },
    {
      'judul': 'Bumi Manusia',
      'pengarang': 'Pramoedya Ananta Toer',
      'tahunTerbit': 1980,
      'rating': 4.7,
      'tersedia': false,
      'genre': 'Sejarah',
      'catatanPeminjam': null, 
    },
    {
      'judul': 'Filosfi Teras',
      'pengarang': 'Henry Manampiring',
      'tahunTerbit': 2018,
      'rating': 4.6,
      'tersedia': true,
      'genre': 'Self Improvement',
      'catatanPeminjam': 'Halaman 50 ada sedikit coretan pensil.',
    },
    {
      'judul': 'Atomic Habits',
      'pengarang': 'James Clear',
      'tahunTerbit': 2018,
      'rating': 4.9,
      'tersedia': false,
      'genre': 'Self Improvement',
      'catatanPeminjam': null, 
    },
    {
      'judul': 'Komet',
      'pengarang': 'Tere Liye',
      'tahunTerbit': 2018,
      'rating': 4.0,
      'tersedia': true,
      'genre': 'Petualangan',
      'catatanPeminjam': 'Sampul sedikit terlipat.',
    },
    {
      'judul': 'Pengantar Pemrograman Dart',
      'pengarang': 'Anonim',
      'tahunTerbit': 2021,
      'rating': 3.2,
      'tersedia': true,
      'genre': 'Teknologi',
      'catatanPeminjam': null, 
    },
  ];

  String _searchQuery = '';
  Set<String> get _daftarGenre {
    return _bukuList.map((buku) => buku['genre'] as String).toSet();
  }

  List<Map<String, dynamic>> get _filteredBuku {
    return _bukuList.where((buku) {
      final judul = buku['judul'].toString().toLowerCase();
      return judul.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Buku Perpustakaan Mini'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Cari Judul Buku...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Genre:', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Wrap(
                  spacing: 6.0,
                  children: _daftarGenre
                      .map((genre) => Chip(
                            label: Text(genre),
                            backgroundColor: Colors.blue.shade50,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          const Divider(),

          Expanded(
            child: ListView.builder(
              itemCount: _filteredBuku.length,
              itemBuilder: (context, index) {
                final buku = _filteredBuku[index];
                final isTersedia = buku['tersedia'] as bool;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                      buku['judul'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pengarang: ${buku['pengarang']} (${buku['tahunTerbit']})'),
                        Text(
                          'Rating: ${buku['rating']} - ${kategoriRating(buku['rating'])}',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                 
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: isTersedia ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isTersedia ? 'Tersedia' : 'Dipinjam',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    onTap: () {
                     
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBukuPage(buku: buku),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBukuPage extends StatefulWidget {
  final Map<String, dynamic> buku;

  const DetailBukuPage({super.key, required this.buku});

  @override
  State<DetailBukuPage> createState() => _DetailBukuPageState();
}

class _DetailBukuPageState extends State<DetailBukuPage> {
  @override
  Widget build(BuildContext context) {
    final String? catatanPeminjam = widget.buku['catatanPeminjam'];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.buku['judul']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.buku['judul'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Penulis: ${widget.buku['pengarang']}'),
            Text('Tahun Terbit: ${widget.buku['tahunTerbit']}'),
            Text('Genre: ${widget.buku['genre']}'),
            Text('Rating: ${widget.buku['rating']} (${kategoriRating(widget.buku['rating'])})'),
            const SizedBox(height: 16),
            const Text(
              'Catatan Peminjam:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                catatanPeminjam ?? 'Tidak ada catatan',
                style: TextStyle(
                fontStyle: catatanPeminjam == null ? FontStyle.italic : FontStyle.normal,
                 color: catatanPeminjam == null ? const Color.fromARGB(255, 36, 127, 202) : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}