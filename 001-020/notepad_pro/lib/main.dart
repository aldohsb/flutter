import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notepad_pro/services/hive_service.dart';
import 'package:notepad_pro/providers/note_provider.dart';
import 'package:notepad_pro/providers/folder_provider.dart';
import 'package:notepad_pro/providers/tag_provider.dart';
import 'package:notepad_pro/screens/home_screen.dart';
import 'package:notepad_pro/theme/app_theme.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  final hiveService = HiveService();
  await hiveService.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteProvider()..loadNotes(),
        ),
        ChangeNotifierProvider(
          create: (context) => FolderProvider()..loadFolders(),
        ),
        ChangeNotifierProvider(
          create: (context) => TagProvider()..loadTags(),
        ),
      ],
      child: MaterialApp(
        title: 'NotePadPro',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}