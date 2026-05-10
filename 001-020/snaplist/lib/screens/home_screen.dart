import 'package:flutter/material.dart'; // import library Flutter untuk semua widget yang dipakai di sini
import '../models/task.dart'; // import model Task — struktur data satu item tugas
import '../widgets/task_tile.dart'; // import widget TaskTile — tampilan satu baris task

class HomeScreen extends StatefulWidget { // StatefulWidget karena list task akan berubah-ubah
  const HomeScreen({super.key}); // constructor const dengan super.key untuk identifikasi widget

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // Flutter panggil ini untuk membuat objek State
}

class _HomeScreenState extends State<HomeScreen> { // class State — tempat semua logika dan data disimpan
  final List<Task> _tasks = []; // list kosong sebagai data utama — diawali tanpa task
  final _controller = TextEditingController(); // controller untuk membaca dan mengontrol isi TextField
  int _idCounter = 0; // angka yang terus naik — dipakai sebagai ID unik setiap task baru

  void _addTask() { // fungsi menambah task baru ke list
    final text = _controller.text.trim(); // ambil teks dari TextField, hapus spasi di awal/akhir
    if (text.isEmpty) return; // batalkan kalau user tidak mengetik apa-apa

    setState(() { // bungkus perubahan data dalam setState agar Flutter tahu perlu rebuild
      _tasks.insert( // insert ke index 0 agar task baru muncul di paling atas list
        0, // index 0 = posisi pertama
        Task(id: '${_idCounter++}', title: text), // buat Task baru, _idCounter++ pakai nilai lama lalu tambah 1
      );
      _controller.clear(); // kosongkan TextField setelah task berhasil ditambahkan
    });
  }

  void _toggleTask(int index) { // fungsi mengubah status selesai/belum dari task tertentu
    setState(() { // setState agar perubahan langsung terlihat di UI
      _tasks[index] = _tasks[index].copyWith( // ganti task lama dengan Task baru hasil copyWith
        isDone: !_tasks[index].isDone, // balik nilai isDone — true jadi false, false jadi true
      );
    });
  }

  void _deleteTask(int index) { // fungsi menghapus task dari list berdasarkan posisi
    setState(() => _tasks.removeAt(index)); // removeAt hapus elemen di index tertentu, setState rebuild UI
  }

  int get _doneCount => _tasks.where((t) => t.isDone).length; // hitung jumlah task yang isDone == true
  // 'get' berarti ini computed property — dihitung ulang setiap kali dipanggil, bukan disimpan

  @override
  void dispose() { // dipanggil Flutter saat widget ini dihapus dari tree (misal: pindah halaman)
    _controller.dispose(); // wajib dispose controller agar tidak ada memory leak
    super.dispose(); // panggil dispose milik parent class
  }

  @override
  Widget build(BuildContext context) { // Flutter panggil ini setiap kali setState dipanggil
    final color = Theme.of(context).colorScheme; // ambil skema warna dari tema global app

    return Scaffold( // layout dasar halaman — menyediakan body, appBar, floatingActionButton, dll
      backgroundColor: const Color(0xFFF5F5F7), // latar belakang abu-abu sangat terang agar tile menonjol
      body: SafeArea( // pastikan konten tidak tertutup notch, status bar, atau gesture bar
        child: Column( // susun elemen secara vertikal: header di atas, list di bawah
          crossAxisAlignment: CrossAxisAlignment.start, // rata kiri untuk semua anak Column
          children: [
            Padding( // tambah jarak di sekitar area header dan input
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0), // kiri 20, atas 24, kanan 20, bawah 0
              child: Column( // Column kedua khusus untuk judul dan input
                crossAxisAlignment: CrossAxisAlignment.start, // rata kiri
                children: [
                  Text( // teks judul besar "snaplist"
                    'snaplist',
                    style: TextStyle(
                      fontSize: 28, // ukuran besar — identitas app
                      fontWeight: FontWeight.w700, // tebal maksimal
                      color: color.primary, // warna ungu dari tema
                      letterSpacing: -0.5, // sedikit rapat — kesan modern
                    ),
                  ),
                  const SizedBox(height: 4), // jarak kecil antara judul dan teks progress
                  Text( // teks progress "X dari Y selesai"
                    _tasks.isEmpty // cek apakah list kosong
                        ? 'Belum ada tugas' // pesan saat list kosong
                        : '$_doneCount dari ${_tasks.length} selesai', // progress aktif
                    style: TextStyle(
                      fontSize: 13, // kecil — info sekunder
                      color: Colors.grey.shade500, // abu-abu — tidak terlalu mencolok
                    ),
                  ),
                  const SizedBox(height: 20), // jarak antara teks progress dan input
                  Row( // input dan tombol plus disusun horizontal
                    children: [
                      Expanded( // TextField mengisi sisa ruang setelah tombol plus
                        child: TextField( // input teks untuk nama task baru
                          controller: _controller, // hubungkan controller agar bisa baca/clear nilainya
                          onSubmitted: (_) => _addTask(), // panggil _addTask saat user tekan Enter/Done
                          decoration: InputDecoration( // styling tampilan TextField
                            hintText: 'Tambah tugas baru...', // teks placeholder saat kosong
                            hintStyle: TextStyle( // style teks placeholder
                              color: Colors.grey.shade400, // abu terang
                              fontSize: 14,
                            ),
                            filled: true, // aktifkan fillColor
                            fillColor: Colors.white, // background TextField putih bersih
                            contentPadding: const EdgeInsets.symmetric( // padding dalam TextField
                              horizontal: 16,
                              vertical: 14,
                            ),
                            border: OutlineInputBorder( // border TextField
                              borderRadius: BorderRadius.circular(14), // sudut melengkung
                              borderSide: BorderSide.none, // hapus garis border bawaan
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10), // jarak antara TextField dan tombol plus
                      GestureDetector( // area tap untuk tombol tambah (+)
                        onTap: _addTask, // panggil _addTask saat tombol ditekan
                        child: Container( // kotak ungu dengan ikon plus
                          width: 48, // lebar tombol
                          height: 48, // tinggi tombol — sama dengan tinggi TextField agar sejajar
                          decoration: BoxDecoration(
                            color: color.primary, // warna ungu dari tema
                            borderRadius: BorderRadius.circular(14), // sudut melengkung konsisten
                          ),
                          child: const Icon(Icons.add, color: Colors.white), // ikon plus putih
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20), // jarak antara input dan list
                ],
              ),
            ),
            Expanded( // bagian bawah mengisi sisa layar — tempat list task atau pesan kosong
              child: _tasks.isEmpty // cek apakah belum ada task
                  ? Center( // kalau kosong, tampilkan teks di tengah layar
                      child: Text(
                        '✦  Tulis sesuatu di atas', // panduan ringan agar user tahu harus ke mana
                        style: TextStyle(
                          color: Colors.grey.shade300, // sangat pudar — tidak menganggu
                          fontSize: 15,
                        ),
                      ),
                    )
                  : ListView.builder( // kalau ada task, tampilkan dalam list yang bisa di-scroll
                      padding: const EdgeInsets.only(bottom: 24), // ruang ekstra di bawah list
                      itemCount: _tasks.length, // jumlah item sama dengan panjang list
                      itemBuilder: (context, index) => TaskTile( // bangun satu TaskTile per item
                        task: _tasks[index], // data task di posisi index ini
                        onToggle: () => _toggleTask(index), // callback toggle dengan index yang benar
                        onDelete: () => _deleteTask(index), // callback delete dengan index yang benar
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}