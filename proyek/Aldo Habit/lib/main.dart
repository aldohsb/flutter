import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'models/habit.dart';
import 'models/weight_entry.dart';
import 'models/earning_entry.dart';
import 'providers/habit_provider.dart';
import 'providers/weight_provider.dart';
import 'providers/earning_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(WeightEntryAdapter());
  Hive.registerAdapter(WeightGoalAdapter());
  Hive.registerAdapter(EarningEntryAdapter());
  Hive.registerAdapter(EarningGoalAdapter());

  // Open boxes
  await Hive.openBox<Habit>('habits');
  await Hive.openBox<WeightEntry>('weight_entries');
  await Hive.openBox<WeightGoal>('weight_goal');
  await Hive.openBox<EarningEntry>('earning_entries');
  await Hive.openBox<EarningGoal>('earning_goal');
  await Hive.openBox('settings'); // untuk lastCheckedDate

  runApp(const AldoHabitApp());
}

class AldoHabitApp extends StatelessWidget {
  const AldoHabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HabitProvider()),
        ChangeNotifierProvider(create: (_) => WeightProvider()),
        ChangeNotifierProvider(create: (_) => EarningProvider()),
      ],
      child: MaterialApp(
        title: 'Aldo Habit',
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
