// Main entry point aplikasi Water Reminder

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/water_provider.dart';
import 'screens/home_screen.dart';
import 'screens/goals_screen.dart';
import 'screens/stats_screen.dart';
import 'utils/theme.dart';
import 'utils/constants.dart';

// Function main adalah entry point dari aplikasi Flutter
void main() async {
  // WidgetsFlutterBinding memastikan binding sudah ready
  // diperlukan saat ada async operation sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();
  
  // Run aplikasi
  runApp(const MyApp());
}

// Root widget aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider untuk provide multiple providers
    // Dalam kasus ini kita hanya pakai 1 provider: WaterProvider
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider untuk WaterProvider
        // create: factory function untuk create instance
        // lazy: false berarti langsung create saat app start
        ChangeNotifierProvider<WaterProvider>(
          create: (context) => WaterProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        // Konfigurasi aplikasi
        title: 'Water Reminder',
        debugShowCheckedModeBanner: false, // Hilangkan banner debug
        
        // Theme dari theme.dart
        theme: AppTheme.lightTheme(),
        
        // Home screen: MainNavigationScreen dengan bottom nav
        home: const MainNavigationScreen(),
      ),
    );
  }
}

// Main navigation screen dengan bottom navigation bar
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  // Index untuk track current page
  int _currentIndex = 0;
  
  // Flag untuk track apakah sudah initialized
  bool _initialized = false;

  // List of screens untuk navigation
  // Hilangkan const karena screens bukan const
  final List<Widget> _screens = [
    const HomeScreen(),
    const GoalsScreen(),
    const StatsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize provider setelah widget ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  // Method untuk initialize app
  Future<void> _initializeApp() async {
    try {
      // Get provider instance
      final provider = context.read<WaterProvider>();
      
      // Initialize provider
      await provider.initialize();
      
      // Set initialized flag
      if (mounted) {
        setState(() {
          _initialized = true;
        });
      }
    } catch (e) {
      // Handle error
      debugPrint('Error initializing app: $e');
      
      // Show error dialog
      if (mounted) {
        _showErrorDialog(e.toString());
      }
    }
  }

  // Show error dialog
  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      barrierDismissible: false, // User harus tap button untuk close
      builder: (context) => AlertDialog(
        title: const Text('Initialization Error'),
        content: Text(
          'Failed to initialize app: $error\n\nPlease restart the app.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Retry initialization
              _initializeApp();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show splash screen saat loading
    if (!_initialized) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo
              Icon(
                Icons.water_drop,
                size: 100,
                color: AppConstants.primaryColor,
              ),
              SizedBox(height: AppConstants.paddingLarge),
              
              // App name
              Text(
                'Water Reminder',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeXXLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppConstants.paddingLarge),
              
              // Loading indicator
              CircularProgressIndicator(),
              SizedBox(height: AppConstants.paddingNormal),
              
              Text(
                'Initializing...',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeMedium,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    // Main scaffold dengan bottom navigation
    return Scaffold(
      // Body: tampilkan screen sesuai current index
      body: IndexedStack(
        // IndexedStack keep state dari semua screens
        // jadi tidak rebuild saat pindah tab
        index: _currentIndex,
        children: _screens,
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Update current index
          setState(() {
            _currentIndex = index;
          });
        },
        // Items untuk navigation
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            activeIcon: Icon(Icons.emoji_events),
            label: 'Goals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
        ],
      ),
    );
  }
}