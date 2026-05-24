import 'package:flutter/material.dart';          // impor Material Design — wajib di setiap app Flutter

void main() => runApp(const NotepadApp());       // titik masuk app

class NotepadApp extends StatelessWidget {
  const NotepadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notepad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const NoteListScreen(),
    );
  }
}

class Note {                                     // model data satu catatan
  final String title;
  final String body;
  final DateTime createdAt;

  Note({
    required this.title,
    required this.body,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();  // initializer list — set createdAt sebelum body constructor
}

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final List<Note> _notes = [
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

  String _preview(String body) {
    if (body.length <= 60) return body;
    return '${body.substring(0, 60)}...';
  }

  void _openNote(BuildContext context, int index) {    // buka layar detail untuk catatan di index ini
    Navigator.push(                                    // push: tambah layar baru di atas stack navigasi
      context,                                         // context diperlukan Navigator untuk tahu di mana posisi kita
      MaterialPageRoute(                               // bungkus layar dalam route dengan animasi slide bawaan Material
        builder: (context) => NoteDetailScreen(        // buat NoteDetailScreen dan oper catatan yang dipilih
          note: _notes[index],                         // kirim objek Note ke layar detail lewat constructor
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Catatan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _notes.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final Note note = _notes[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              title: Text(
                note.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                _preview(note.body),
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () => _openNote(context, index),  // tap card → buka layar detail
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},                              // tambah catatan menyusul di Part 3
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteDetailScreen extends StatelessWidget {      // layar detail — StatelessWidget karena hanya tampilkan data
  final Note note;                                    // catatan yang akan ditampilkan — diterima dari NoteListScreen

  const NoteDetailScreen({                            // constructor — note wajib diisi
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: IconButton(                          // tombol back kustom di kiri AppBar
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),   // pop: kembali ke layar sebelumnya (NoteListScreen)
        ),
        title: Text(
          note.title,                                // judul catatan sebagai judul AppBar
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,           // potong judul panjang di AppBar
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(                   // scroll jika isi catatan sangat panjang
        padding: const EdgeInsets.all(24),
        child: Text(
          note.body,                                 // tampilkan isi catatan lengkap — tanpa batas maxLines
          style: const TextStyle(
            fontSize: 16,
            height: 1.6,                            // jarak antar baris 1.6× ukuran font — lebih mudah dibaca
            color: Color(0xFF2A2A2A),
          ),
        ),
      ),
    );
  }
}