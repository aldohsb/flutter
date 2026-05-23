import 'package:flutter/material.dart';          // impor Material Design — wajib di setiap app Flutter

void main() => runApp(const HabitFlowApp());     // titik masuk app

class Habit {
  final String title;
  final bool isDone;

  const Habit({
    required this.title,
    this.isDone = false,
  });

  Habit copyWith({bool? isDone}) {
    return Habit(
      title: title,
      isDone: isDone ?? this.isDone,
    );
  }
}

class HabitFlowApp extends StatelessWidget {
  const HabitFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HabitScreen(),
    );
  }
}

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final DateTime _today = DateTime.now();

  List<Habit> _habits = [
    const Habit(title: 'Minum 8 gelas air'),
    const Habit(title: 'Olahraga 30 menit'),
    const Habit(title: 'Baca buku 20 menit'),
    const Habit(title: 'Meditasi'),
    const Habit(title: 'Tidur sebelum jam 11'),
  ];

  final TextEditingController _controller = TextEditingController(); // controller untuk TextField — baca dan bersihkan teks input

  String _formatDate(DateTime date) {
    const List<String> months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    const List<String> days = [
      '', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu',
    ];
    return '${days[date.weekday]}, ${date.day} ${months[date.month]} ${date.year}';
  }

  int get _doneCount => _habits.where((h) => h.isDone).length;

  void _toggleHabit(int index) {
    setState(() {
      _habits[index] = _habits[index].copyWith(
        isDone: !_habits[index].isDone,
      );
    });
  }

  void _addHabit(String title) {                 // tambah habit baru ke list — terima judul dari TextField
    final String trimmed = title.trim();         // hapus spasi di awal dan akhir — hindari habit dengan nama "   "
    if (trimmed.isEmpty) return;                 // abaikan kalau input kosong atau hanya spasi
    setState(() {
      _habits = [..._habits, Habit(title: trimmed)]; // spread list lama + item baru — lebih idiomatis dari .add()
    });
    _controller.clear();                         // kosongkan TextField setelah berhasil tambah
  }

  void _showAddSheet() {                         // tampilkan bottom sheet untuk input habit baru
    showModalBottomSheet(                        // modal di atas layar — konten di bawah tetap terlihat tapi tidak bisa ditekan
      context: context,
      isScrollControlled: true,                  // izinkan sheet naik mengikuti keyboard — tanpa ini input tertutup keyboard
      shape: const RoundedRectangleBorder(       // sudut atas membulat — tampilan modern
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {                       // builder dipanggil satu kali untuk membangun konten sheet
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24, // tambah tinggi keyboard agar input tidak tertutup
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,       // Column setinggi kontennya saja — tidak memenuhi layar
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Habit Baru',                    // judul sheet
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,         // hubungkan controller agar bisa baca nilai teks
                autofocus: true,                 // langsung fokus ke TextField saat sheet terbuka — keyboard langsung muncul
                textCapitalization: TextCapitalization.sentences, // huruf pertama kapital otomatis
                decoration: InputDecoration(
                  hintText: 'Contoh: Minum vitamin',
                  filled: true,                  // aktifkan warna latar TextField
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none, // hilangkan garis tepi — tampilan lebih bersih
                  ),
                ),
                onSubmitted: (value) {           // dipanggil saat user tekan Enter / Done di keyboard
                  _addHabit(value);              // tambah habit
                  Navigator.pop(context);        // tutup sheet setelah submit
                },
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,          // tombol selebar container — lebih mudah ditekan
                child: ElevatedButton(
                  onPressed: () {
                    _addHabit(_controller.text); // tambah habit dari nilai controller saat tombol ditekan
                    Navigator.pop(context);      // tutup sheet
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tambah',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();                       // bebaskan memori controller saat widget dihancurkan — wajib untuk TextEditingController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      floatingActionButton: FloatingActionButton( // tombol bulat mengambang di pojok kanan bawah
        onPressed: _showAddSheet,                // buka bottom sheet saat ditekan
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),            // ikon + sebagai label visual
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                _formatDate(_today),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.teal.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Hari Ini',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$_doneCount dari ${_habits.length} selesai',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: _habits.length,
                  itemBuilder: (context, index) {
                    final Habit habit = _habits[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CheckboxListTile(
                        value: habit.isDone,
                        onChanged: (bool? value) => _toggleHabit(index),
                        title: Text(
                          habit.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: habit.isDone
                                ? TextDecoration.lineThrough
                                : null,
                            color: habit.isDone
                                ? Colors.grey.shade400
                                : const Color(0xFF1A1A1A),
                          ),
                        ),
                        activeColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}