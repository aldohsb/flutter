import 'package:flutter/material.dart';                  // diperlukan untuk StatefulWidget, Scaffold, dll
import 'package:habitflow/models/habit.dart';            // impor model Habit
import 'package:habitflow/widgets/habit_card.dart';      // impor widget HabitCard

class HabitScreen extends StatefulWidget {               // layar utama — dipindah dari main.dart
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final DateTime _today = DateTime.now();                // tanggal hari ini — dipakai di header

  List<Habit> _habits = [                                // list habit awal
    const Habit(title: 'Minum 8 gelas air'),
    const Habit(title: 'Olahraga 30 menit'),
    const Habit(title: 'Baca buku 20 menit'),
    const Habit(title: 'Meditasi'),
    const Habit(title: 'Tidur sebelum jam 11'),
  ];

  final TextEditingController _controller = TextEditingController(); // controller untuk TextField di bottom sheet

  @override
  void dispose() {
    _controller.dispose();                               // bebaskan memori controller saat layar dihancurkan
    super.dispose();
  }

  String _formatDate(DateTime date) {                    // ubah DateTime ke string hari + tanggal
    const List<String> months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    const List<String> days = [
      '', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu',
    ];
    return '${days[date.weekday]}, ${date.day} ${months[date.month]} ${date.year}';
  }

  int get _doneCount => _habits.where((h) => h.isDone).length; // hitung habit selesai

  void _toggleHabit(int index) {                         // toggle isDone habit di posisi index
    setState(() {
      _habits[index] = _habits[index].copyWith(
        isDone: !_habits[index].isDone,                  // balik nilai boolean
      );
    });
  }

  void _addHabit(String title) {                         // tambah habit baru ke list
    final String trimmed = title.trim();                 // hapus spasi di awal/akhir
    if (trimmed.isEmpty) return;                         // abaikan input kosong
    setState(() {
      _habits = [..._habits, Habit(title: trimmed)];     // spread list lama + item baru
    });
    _controller.clear();                                 // kosongkan TextField
  }

  void _showAddSheet() {                                 // tampilkan bottom sheet input habit baru
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,                          // sheet naik mengikuti keyboard
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24, // padding ikuti tinggi keyboard
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,               // column setinggi konten saja
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Habit Baru',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                autofocus: true,                          // keyboard langsung muncul
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Contoh: Minum vitamin',
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  _addHabit(value);
                  Navigator.pop(context);                 // tutup sheet setelah submit
                },
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,                   // tombol selebar layar
                child: ElevatedButton(
                  onPressed: () {
                    _addHabit(_controller.text);
                    Navigator.pop(context);
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSheet,                         // buka bottom sheet
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
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
                    return HabitCard(                     // pakai HabitCard — bukan CheckboxListTile langsung
                      habit: _habits[index],             // oper data habit ke widget
                      onToggle: () => _toggleHabit(index), // oper callback toggle — screen yang pegang logikanya
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