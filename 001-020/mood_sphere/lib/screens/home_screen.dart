import 'package:flutter/material.dart';
import '../models/mood_model.dart';
import '../widgets/mood_button.dart';
import '../widgets/floating_blob.dart';
import '../utils/color_generator.dart';

/// Home Screen - Layar utama aplikasi MoodSphere
/// StatefulWidget karena kita track mood yang dipilih
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State variable untuk track mood yang dipilih
  String _selectedMood = '';
  
  // List background blobs yang akan ditampilkan
  late List<Widget> _backgroundBlobs;

  /// initState - Inisialisasi state awal
  @override
  void initState() {
    super.initState();
    
    // Generate background blobs dengan posisi dan warna random
    _backgroundBlobs = _generateBackgroundBlobs();
  }

  /// Method untuk generate background blobs
  /// Returns: List of FloatingBlob widgets
  List<Widget> _generateBackgroundBlobs() {
    return [
      // Blob 1 - Kiri atas
      FloatingBlob(
        size: 200,
        color: ColorGenerator.generatePastelColor(),
        top: -50,
        left: -50,
      ),
      
      // Blob 2 - Kanan atas
      FloatingBlob(
        size: 180,
        color: ColorGenerator.generatePastelColor(),
        top: 50,
        right: -60,
      ),
      
      // Blob 3 - Kiri bawah
      FloatingBlob(
        size: 220,
        color: ColorGenerator.generatePastelColor(),
        bottom: 100,
        left: -70,
      ),
      
      // Blob 4 - Kanan bawah
      FloatingBlob(
        size: 190,
        color: ColorGenerator.generatePastelColor(),
        bottom: -30,
        right: -40,
      ),
      
      // Blob 5 - Tengah kiri
      FloatingBlob(
        size: 150,
        color: ColorGenerator.generatePastelColor(),
        top: 300,
        left: -40,
      ),
    ];
  }

  /// Method untuk handle ketika mood button di-tap
  void _onMoodSelected(MoodModel mood) {
    // Update state dengan mood yang dipilih
    setState(() {
      _selectedMood = mood.label;
      
      // Regenerate background blobs dengan warna baru
      _backgroundBlobs = _generateBackgroundBlobs();
    });

    // Show snackbar untuk feedback ke user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'You\'re feeling ${mood.label} ${mood.emoji}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: ColorGenerator.generateVibrantColor(),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get list of all moods
    final moods = MoodModel.getMoods();

    return Scaffold(
      // Background dengan gradient
      body: Container(
        // Decoration untuk background gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e), // Dark blue
              Color(0xFF16213e), // Darker blue
              Color(0xFF0f3460), // Deep blue
            ],
          ),
        ),
        
        // Stack untuk layer background blobs dan content
        child: Stack(
          children: [
            // Layer 1: Background Blobs
            // Spread operator (...) untuk insert list items
            ..._backgroundBlobs,
            
            // Layer 2: Main Content
            SafeArea(
              child: Column(
                children: [
                  // Header Section
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // App Title
                        const Text(
                          'MoodSphere',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Subtitle
                        Text(
                          'How are you feeling today?',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        
                        // Display selected mood if any
                        if (_selectedMood.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'Current: $_selectedMood',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // Mood Buttons Grid
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.builder(
                        // Physics untuk smooth scrolling
                        physics: const BouncingScrollPhysics(),
                        
                        // Grid configuration
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 kolom
                          crossAxisSpacing: 16, // Jarak horizontal antar item
                          mainAxisSpacing: 16, // Jarak vertical antar item
                          childAspectRatio: 1, // Aspect ratio 1:1 (kotak)
                        ),
                        
                        // Jumlah items
                        itemCount: moods.length,
                        
                        // Builder untuk setiap item
                        itemBuilder: (context, index) {
                          final mood = moods[index];
                          
                          return MoodButton(
                            mood: mood,
                            onTap: () => _onMoodSelected(mood),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  // Bottom padding
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}