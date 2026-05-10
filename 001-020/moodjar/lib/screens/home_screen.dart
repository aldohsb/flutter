import 'package:flutter/material.dart';
import '../models/mood.dart';
import '../widgets/mood_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MoodType? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hari ini kamu merasa...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: moods.map((mood) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: MoodButton(
                    mood: mood,
                    isSelected: _selected == mood.type,
                    onTap: () => setState(() => _selected = mood.type),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 48),
            if (_selected != null)
              Text(
                'Dicatat ✓',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}