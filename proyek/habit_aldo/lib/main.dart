import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/habit.dart';
import 'models/weight_entry.dart';
import 'models/earning_entry.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(WeightEntryAdapter());
  Hive.registerAdapter(WeightGoalAdapter());
  Hive.registerAdapter(EarningEntryAdapter());
  Hive.registerAdapter(MonthlyEarningGoalAdapter());

  runApp(const AppProviders());
}
