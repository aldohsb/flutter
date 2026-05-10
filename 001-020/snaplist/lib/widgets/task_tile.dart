import 'package:flutter/material.dart'; // import widget Material Design seperti ListTile, Container, dll
import '../models/task.dart'; // import model Task agar widget ini tahu struktur datanya

class TaskTile extends StatelessWidget { // widget satu baris task — StatelessWidget karena state dikelola parent
  final Task task; // data task yang akan ditampilkan — diterima dari HomeScreen
  final VoidCallback onToggle; // fungsi yang dipanggil saat user tap lingkaran centang
  final VoidCallback onDelete; // fungsi yang dipanggil saat user swipe hapus

  const TaskTile({ // constructor const — bisa di-cache Flutter kalau data tidak berubah
    super.key, // key diteruskan ke parent untuk identifikasi dalam widget tree
    required this.task, // task wajib diisi
    required this.onToggle, // callback toggle wajib diisi
    required this.onDelete, // callback delete wajib diisi
  });

  @override
  Widget build(BuildContext context) { // Flutter panggil ini setiap kali task atau state berubah
    return Dismissible( // widget bawaan Flutter yang menangani animasi swipe kiri/kanan
      key: Key(task.id), // Key WAJIB unik — Flutter pakai ini untuk tahu widget mana yang dihapus
      direction: DismissDirection.endToStart, // hanya boleh swipe dari kanan ke kiri
      onDismissed: (_) => onDelete(), // panggil onDelete saat animasi swipe selesai
      background: Container( // tampilan merah yang muncul di belakang saat user menggeser
        alignment: Alignment.centerRight, // ikon trash rata kanan karena swipe dari kanan
        padding: const EdgeInsets.only(right: 20), // jarak ikon dari tepi kanan
        decoration: BoxDecoration( // dekorasi background dengan sudut melengkung
          color: Colors.redAccent.shade100, // merah muda sebagai sinyal "hapus"
          borderRadius: BorderRadius.circular(16), // sudut melengkung supaya konsisten dengan tile
        ),
        child: const Icon(Icons.delete_outline, color: Colors.redAccent), // ikon tempat sampah
      ),
      child: AnimatedContainer( // Container yang bisa beranimasi saat propertinya berubah
        duration: const Duration(milliseconds: 250), // durasi transisi saat task selesai/belum
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), // jarak antar tile
        decoration: BoxDecoration( // dekorasi visual tile (warna, shadow, sudut)
          color: task.isDone // warna berubah tergantung status isDone
              ? Colors.grey.shade100 // abu-abu kalau sudah selesai
              : Theme.of(context).colorScheme.surface, // putih/surface kalau belum selesai
          borderRadius: BorderRadius.circular(16), // sudut melengkung konsisten di semua tile
          boxShadow: task.isDone // shadow hanya tampil kalau task belum selesai
              ? [] // tidak ada shadow kalau sudah selesai — terlihat "flat" dan kusam
              : [ // shadow halus untuk task yang masih aktif — memberi kesan "mengambang"
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // shadow sangat transparan, tidak mengganggu
                    blurRadius: 8, // seberapa lebar efek blur shadow
                    offset: const Offset(0, 2), // shadow turun 2px ke bawah
                  ),
                ],
        ),
        child: ListTile( // widget standar Flutter untuk baris dengan leading, title, trailing
          contentPadding: const EdgeInsets.symmetric( // atur padding dalam ListTile
            horizontal: 16, // jarak kiri-kanan konten
            vertical: 4, // sedikit ruang atas-bawah
          ),
          leading: GestureDetector( // area tap untuk lingkaran centang di kiri
            onTap: onToggle, // panggil toggle saat user tap lingkaran
            child: AnimatedContainer( // lingkaran yang beranimasi antara kosong dan terisi
              duration: const Duration(milliseconds: 200), // transisi cepat 200ms
              width: 26, // lebar lingkaran
              height: 26, // tinggi lingkaran
              decoration: BoxDecoration( // bentuk dan warna lingkaran
                shape: BoxShape.circle, // bentuk bulat sempurna
                color: task.isDone // warna isi lingkaran
                    ? Theme.of(context).colorScheme.primary // ungu kalau selesai
                    : Colors.transparent, // transparan kalau belum selesai
                border: Border.all( // garis tepi lingkaran
                  color: task.isDone // warna border sesuai status
                      ? Theme.of(context).colorScheme.primary // ungu kalau selesai
                      : Colors.grey.shade400, // abu-abu kalau belum selesai
                  width: 2, // ketebalan border 2 piksel
                ),
              ),
              child: task.isDone // ikon centang hanya muncul kalau task selesai
                  ? const Icon(Icons.check, size: 16, color: Colors.white) // centang putih di dalam lingkaran
                  : null, // tidak ada isi kalau belum selesai
            ),
          ),
          title: AnimatedDefaultTextStyle( // teks yang beranimasi saat style-nya berubah
            duration: const Duration(milliseconds: 200), // transisi 200ms
            style: TextStyle( // style teks berubah tergantung isDone
              fontSize: 15, // ukuran teks normal
              fontWeight: FontWeight.w500, // sedikit tebal
              color: task.isDone // warna teks memudar kalau selesai
                  ? Colors.grey.shade400 // abu terang — terlihat "selesai dan tidak penting"
                  : Colors.grey.shade800, // hampir hitam kalau masih aktif
              decoration: task.isDone // garis coret muncul kalau sudah selesai
                  ? TextDecoration.lineThrough // garis tengah teks — sinyal visual "sudah dikerjakan"
                  : TextDecoration.none, // tidak ada dekorasi kalau belum selesai
            ),
            child: Text(task.title), // teks judul task yang sebenarnya
          ),
        ),
      ),
    );
  }
}