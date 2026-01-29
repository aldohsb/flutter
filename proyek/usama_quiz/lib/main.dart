import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/app_theme.dart';
import 'services/hive_service.dart';
import 'services/quiz_service.dart';
import 'services/audio_service.dart';
import 'providers/app_providers.dart';
import 'screens/user_selection/user_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  final hiveService = HiveService();
  await hiveService.init();
  
  // Initialize Audio
  final audioService = AudioService();
  await audioService.init();
  
  runApp(
    MultiProvider(
      providers: [
        Provider<HiveService>(create: (_) => hiveService),
        Provider<QuizService>(create: (_) => QuizService()),
        Provider<AudioService>(create: (_) => audioService),
        ChangeNotifierProvider(
          create: (context) => UserProvider(hiveService),
        ),
        ChangeNotifierProvider(
          create: (context) => ProgressProvider(hiveService),
        ),
        ChangeNotifierProvider(
          create: (context) => QuizProvider(QuizService()),
        ),
        ChangeNotifierProvider(
          create: (context) => AudioProvider(audioService),
        ),
      ],
      child: const UsamaQuizApp(),
    ),
  );
}

class UsamaQuizApp extends StatelessWidget {
  const UsamaQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UsamaQuiz - Learn Japanese',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: FutureBuilder(
        future: _initializeApp(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('UsamaQuiz'),
                  ],
                ),
              ),
            );
          }
          return const UserSelectionScreen();
        },
      ),
    );
  }

  Future<void> _initializeApp(BuildContext context) async {
    final userProvider = context.read<UserProvider>();
    final progressProvider = context.read<ProgressProvider>();
    
    await userProvider.loadAllUsers();
    await userProvider.loadCurrentUser();
    
    if (userProvider.currentUsername != null) {
      await progressProvider.loadProgress(userProvider.currentUsername!);
    }
  }
}