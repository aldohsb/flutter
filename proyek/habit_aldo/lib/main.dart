import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/habit.dart';
import 'models/weight_entry.dart';
import 'models/earning_entry.dart';
import 'models/calorie_entry.dart';
import 'models/expense_entry.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(WeightEntryAdapter());
  Hive.registerAdapter(WeightGoalAdapter());
  Hive.registerAdapter(EarningEntryAdapter());
  Hive.registerAdapter(MonthlyEarningGoalAdapter());
  Hive.registerAdapter(CalorieEntryAdapter());
  Hive.registerAdapter(CalorieGoalAdapter());
  Hive.registerAdapter(CustomFoodAdapter());
  Hive.registerAdapter(ExpenseEntryAdapter());
  Hive.registerAdapter(CustomExpenseItemAdapter());

  runApp(const AppProviders());
}