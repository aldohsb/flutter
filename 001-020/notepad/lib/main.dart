import 'package:flutter/material.dart';          // impor Material Design — wajib di setiap app Flutter

void main() => runApp(const NotepadApp());       // titik masuk app

class NotepadApp extends StatelessWidget {       // root widget — hanya konfigurasi, tidak ada logika
  const NotepadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notepad',
      debugShowCheckedModeBanner: false,          // hilangkan banner DEBUG
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), // tema indigo — kesan serius dan fokus
        useMaterial3: true,
      ),
      home: const NoteListScreen(),              // layar pertama: daftar catatan
    );
  }
}

class Note {                                     // model data satu catatan
  final String title;                            // judul catatan — ditampilkan di list
  final String body;                             // isi catatan — ditampilkan di layar detail
  final DateTime createdAt;                      // waktu dibuat — dipakai untuk urutan dan preview

  Note({                                         // constructor — createdAt otomatis kalau tidak diisi
    required this.title,
    required this.body,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();  // initializer list — set createdAt sebelum body constructor
}

class NoteListScreen extends StatefulWidget {    // layar daftar — StatefulWidget karena list akan berubah
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final List<Note> _notes = [                    // list catatan awal — data statis untuk tampilan awal
    Note(
      title: 'Ide Proyek Flutter',
      body: 'Buat app timer, habit tracker, dan notepad dalam 365 hari.',
    ),
    Note(
      title: 'Belanjaan Minggu Ini',
      body: 'Beras, telur, minyak goreng, kecap, dan sayuran.',
    ),
    Note(
      title: 'Rencana Belajar',
      body: 'Navigator, StatefulWidget, animasi, dan state management.',
    ),
  ];

  String _preview(String body) {                 // potong isi catatan untuk ditampilkan di list — max 60 karakter
    if (body.length <= 60) return body;          // kalau pendek, tampilkan semua
    return '${body.substring(0, 60)}...';        // kalau panjang, potong dan tambah "..."
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // putih keabu-abuan — lebih lembut dari putih murni
      appBar: AppBar(
        backgroundColor: Colors.indigo,          // header indigo — konsisten dengan tema
        title: const Text(
          'Catatan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,                            // hilangkan bayangan AppBar — tampilan lebih flat dan modern
      ),
      body: ListView.separated(                  // separated: otomatis tambah divider antar item
        padding: const EdgeInsets.all(16),       // padding di luar list
        itemCount: _notes.length,
        separatorBuilder: (context, index) =>    // widget yang muncul di antara setiap dua item
            const SizedBox(height: 8),           // jarak 8px antar card — lebih rapi dari divider garis
        itemBuilder: (context, index) {
          final Note note = _notes[index];
          return Card(
            elevation: 1,                        // bayangan tipis — memberi kesan card mengambang
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(                     // tile standar dengan judul, subjudul, dan aksi
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,                     // padding vertikal lebih besar agar tile tidak terlalu sempit
              ),
              title: Text(
                note.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                maxLines: 1,                     // judul satu baris — potong kalau terlalu panjang
                overflow: TextOverflow.ellipsis, // tampilkan "..." kalau terpotong
              ),
              subtitle: Text(
                _preview(note.body),             // preview isi — dipotong max 60 karakter
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(             // ikon panah di kanan — sinyal visual "bisa dibuka"
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},                        // belum ada aksi — navigasi menyusul di Part 2
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}