import 'package:flutter/material.dart';   // import widget Flutter
import '../models/mood_entry.dart';        // import enum Mood, moodDataMap, moodOrder

class MoodButtonRow extends StatelessWidget {   // StatelessWidget — tidak punya state sendiri
  final Mood? selectedMood;                     // mood yang sedang aktif — dari parent
  final ValueChanged<Mood> onMoodSelected;      // callback ke parent saat tombol ditekan

  const MoodButtonRow({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,               // parent wajib mengisi callback ini
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: moodOrder.map((mood) {           // iterasi dari moodOrder yang sudah berurutan
        final MoodData data   = moodDataMap[mood]!; // ! aman — moodOrder hanya berisi key yang ada di Map
        final bool isSelected = selectedMood == mood; // true jika ini mood yang aktif

        return GestureDetector(
          onTap: () => onMoodSelected(mood),     // panggil callback parent dengan mood ini
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,           // efek pop kecil saat tombol membesar
            width:  isSelected ? 68.0 : 56.0,   // tombol aktif lebih besar
            height: isSelected ? 68.0 : 56.0,
            decoration: BoxDecoration(
              color: isSelected
                  ? Color(data.colorValue)       // warna aksen mood saat dipilih
                  : Colors.white,                // putih saat tidak dipilih
              borderRadius: BorderRadius.circular(isSelected ? 22.0 : 16.0),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? Color(data.colorValue).withOpacity(0.45)
                      : Colors.black.withOpacity(0.06),
                  blurRadius: isSelected ? 16.0 : 8.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              data.emoji,
              style: TextStyle(fontSize: isSelected ? 32.0 : 28.0), // emoji ikut membesar
            ),
          ),
        );
      }).toList(),
    );
  }
}