import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const LetterHannaApp());
}

class LetterHannaApp extends StatelessWidget {
  const LetterHannaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LetterHanna',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Tema elegant luxurious
        primaryColor: const Color(0xFF2C1810), // Deep burgundy brown
        scaffoldBackgroundColor: const Color(0xFFFFFDF7), // Warm ivory
        fontFamily: 'Playfair Display', // Elegant serif (nanti akan custom)
        
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF2C1810),
          secondary: const Color(0xFFD4AF37), // Gold accent
          surface: Colors.white,
          background: const Color(0xFFFFFDF7),
        ),
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF2C1810)),
          titleTextStyle: TextStyle(
            fontFamily: 'Playfair Display',
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C1810),
            letterSpacing: 2,
          ),
        ),
        
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C1810),
            letterSpacing: 0.5,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C1810),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF5C4B3A),
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF8B7D6B),
            height: 1.5,
          ),
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2C1810),
            foregroundColor: const Color(0xFFFFFDF7),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            elevation: 0,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}