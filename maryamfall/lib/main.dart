import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/game_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lock orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const MaryamFallApp());
}

class MaryamFallApp extends StatelessWidget {
  const MaryamFallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaryamFall',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1a1a2e),
      ),
      home: const GameScreen(),
    );
  }
}