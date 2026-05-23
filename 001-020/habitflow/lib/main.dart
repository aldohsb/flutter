import 'package:flutter/material.dart'; // impor Material Design — wajib di setiap app Flutter

void main() => runApp(const HabitFlowApp()); // titik masuk app

class Habit {
  // model data satu habit
  final String title; // nama habit — tidak berubah setelah dibuat
  final bool isDone; // status selesai hari ini

  const Habit({
    required this.title,
    this.isDone = false, // default false — habit baru selalu belum selesai
  });

  Habit copyWith({bool? isDone}) {
    // buat salinan dengan isDone baru — title tetap sama
    return Habit(
      title: title,
      isDone:
          isDone ??
          this.isDone, // ?? pakai nilai lama kalau parameter tidak diisiR
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

  String _formatDate(DateTime date) {
    const List<String> months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    const List<String> days = [
      '',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    return '${days[date.weekday]}, ${date.day} ${months[date.month]} ${date.year}';
  }

  int get _doneCount =>
      _habits.where((h) => h.isDone).length; // hitung habit yang sudah selesai

  void _toggleHabit(int index) {
    // toggle status habit di posisi index
    setState(() {
      _habits[index] = _habits[index].copyWith(
        // ganti item di index dengan salinan baru
        isDone: !_habits[index]
            .isDone, // balik nilai boolean — true jadi false, false jadi true
      );
    });
  }

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
                '$_doneCount dari ${_habits.length} selesai', // update otomatis setiap setState
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
                        onChanged: (bool? value) => _toggleHabit(
                          index,
                        ), // aktif — panggil toggle saat ditekan
                        title: Text(
                          habit.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration:
                                habit
                                    .isDone // coret teks kalau sudah selesai
                                ? TextDecoration.lineThrough
                                : null, // null = tidak ada dekorasi
                            color: habit.isDone
                                ? Colors
                                      .grey
                                      .shade400 // abu-abu kalau selesai — terasa "mundur"
                                : const Color(
                                    0xFF1A1A1A,
                                  ), // gelap kalau belum — lebih menonjol
                          ),
                        ),
                        activeColor:
                            Colors.teal, // warna centang saat isDone=true
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
