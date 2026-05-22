import 'package:flutter/material.dart';          // impor Material Design — wajib di setiap app Flutter

void main() => runApp(const HabitFlowApp());     // titik masuk app

class Habit {                                    // model data satu habit — menyimpan nama dan status selesai
  final String title;                            // nama habit — tidak berubah setelah dibuat
  final bool isDone;                             // status apakah habit sudah selesai hari ini

  const Habit({                                  // constructor — semua field required agar tidak ada yang kosong
    required this.title,
    this.isDone = false,                         // default false — habit baru selalu belum selesai
  });

  Habit copyWith({bool? isDone}) {               // buat salinan Habit dengan isDone yang baru — field lain tetap sama
    return Habit(
      title: title,                              // title tidak berubah — disalin apa adanya
      isDone: isDone ?? this.isDone,             // pakai nilai baru kalau ada, kalau tidak pakai nilai lama
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
  final DateTime _today = DateTime.now();        // tanggal hari ini — dipakai di header

  List<Habit> _habits = [                        // list habit awal — pakai var bukan final karena nanti diganti saat toggle
    const Habit(title: 'Minum 8 gelas air'),
    const Habit(title: 'Olahraga 30 menit'),
    const Habit(title: 'Baca buku 20 menit'),
    const Habit(title: 'Meditasi'),
    const Habit(title: 'Tidur sebelum jam 11'),
  ];

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

  int get _doneCount =>                          // getter — hitung jumlah habit yang sudah selesai
    _habits.where((h) => h.isDone).length;       // where() filter item yang memenuhi kondisi, .length hitung hasilnya

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
                '$_doneCount dari ${_habits.length} selesai', // hitung dinamis dari list — bukan hardcode "0 dari 0"
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 24),        // jarak antara header dan list
              Expanded(                          // beri sisa tinggi layar ke ListView
                child: ListView.builder(
                  itemCount: _habits.length,     // jumlah item = jumlah habit
                  itemBuilder: (context, index) {
                    final Habit habit = _habits[index]; // ambil habit di posisi index
                    return Card(                 // Card memberi efek bayangan tipis dan sudut membulat
                      margin: const EdgeInsets.only(bottom: 8), // jarak antar card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CheckboxListTile(   // list tile dengan checkbox bawaan — lebih praktis dari Row manual
                        value: habit.isDone,     // status checkbox — true=centang, false=kosong
                        onChanged: null,         // null = tidak bisa ditekan — interaksi menyusul di Part 3
                        title: Text(
                          habit.title,           // nama habit sebagai label utama
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        activeColor: Colors.teal, // warna centang dan kotak saat isDone=true
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // sudut card dan tile harus sama
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