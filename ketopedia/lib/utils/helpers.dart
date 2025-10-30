import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'constants.dart';

class Helpers {
  // Format currency (Indonesian Rupiah)
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  // Format date
  static String formatDate(DateTime date, {String format = 'dd MMM yyyy'}) {
    try {
      final formatter = DateFormat(format, 'id_ID');
      return formatter.format(date);
    } catch (e) {
      // Fallback to default locale if id_ID is not available
      final formatter = DateFormat(format);
      return formatter.format(date);
    }
  }

  // Format time
  static String formatTime(DateTime date) {
    try {
      final formatter = DateFormat('HH:mm', 'id_ID');
      return formatter.format(date);
    } catch (e) {
      final formatter = DateFormat('HH:mm');
      return formatter.format(date);
    }
  }

  // Format weight with unit
  static String formatWeight(double weight) {
    return '${weight.toStringAsFixed(1)} kg';
  }

  // Format BMI
  static String formatBMI(double bmi) {
    return bmi.toStringAsFixed(1);
  }

  // Get BMI color
  static Color getBMIColor(double bmi) {
    if (bmi < AppConstants.bmiUnderweight) {
      return AppConstants.ratingCareful;
    } else if (bmi <= AppConstants.bmiNormal) {
      return AppConstants.ratingExcellent;
    } else if (bmi <= AppConstants.bmiOverweight) {
      return AppConstants.ratingModerate;
    } else {
      return AppConstants.ratingAvoid;
    }
  }

  // Calculate macros from calories
  static Map<String, double> calculateMacros(double calories) {
    final fatCalories = calories * (AppConstants.ketoFatPercent / 100);
    final proteinCalories = calories * (AppConstants.ketoProteinPercent / 100);
    final carbsCalories = calories * (AppConstants.ketoCarbsPercent / 100);

    return {
      'fat': fatCalories / 9, // 9 cal per gram fat
      'protein': proteinCalories / 4, // 4 cal per gram protein
      'carbs': carbsCalories / 4, // 4 cal per gram carbs
    };
  }

  // Calculate daily calories need (Mifflin-St Jeor)
  static double calculateBMR(Gender gender, double weight, double height, int age) {
    if (gender == Gender.pria) {
      return (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      return (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
  }

  // Calculate TDEE (Total Daily Energy Expenditure)
  static double calculateTDEE(double bmr, double activityLevel) {
    // Activity levels:
    // 1.2 = Sedentary (little or no exercise)
    // 1.375 = Lightly active (light exercise 1-3 days/week)
    // 1.55 = Moderately active (moderate exercise 3-5 days/week)
    // 1.725 = Very active (hard exercise 6-7 days/week)
    // 1.9 = Extra active (very hard exercise & physical job)
    return bmr * activityLevel;
  }

  // Get rating badge data
  static Map<String, dynamic> getRatingBadge(int rating) {
    switch (rating) {
      case AppConstants.ratingExcellentValue:
        return {
          'label': 'Sangat Dianjurkan',
          'color': AppConstants.ratingExcellent,
          'icon': Icons.check_circle,
        };
      case AppConstants.ratingModerateValue:
        return {
          'label': 'Moderat',
          'color': AppConstants.ratingModerate,
          'icon': Icons.info,
        };
      case AppConstants.ratingCarefulValue:
        return {
          'label': 'Hati-hati',
          'color': AppConstants.ratingCareful,
          'icon': Icons.warning,
        };
      case AppConstants.ratingAvoidValue:
        return {
          'label': 'Hindari',
          'color': AppConstants.ratingAvoid,
          'icon': Icons.cancel,
        };
      default:
        return {
          'label': 'Unknown',
          'color': Colors.grey,
          'icon': Icons.help,
        };
    }
  }

  // Get days difference
  static int getDaysDifference(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }

  // Get weight change percentage
  static double getWeightChangePercentage(double initial, double current) {
    if (initial == 0) return 0;
    return ((current - initial) / initial) * 100;
  }

  // Format percentage
  static String formatPercentage(double percentage) {
    final sign = percentage >= 0 ? '+' : '';
    return '$sign${percentage.toStringAsFixed(1)}%';
  }

  // Validate email
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Show snackbar helper
  static void showSnackBar(
    BuildContext context, 
    String message, 
    {bool isError = false}
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError 
          ? AppConstants.primaryRed 
          : AppConstants.ratingExcellent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        duration: Duration(seconds: isError ? 4 : 2),
      ),
    );
  }

  // Get greeting based on time
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 15) {
      return 'Selamat Siang';
    } else if (hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  // Get motivational emoji based on progress
  static String getProgressEmoji(double progressPercentage) {
    if (progressPercentage >= 80) {
      return '🔥';
    } else if (progressPercentage >= 60) {
      return '💪';
    } else if (progressPercentage >= 40) {
      return '⚡';
    } else if (progressPercentage >= 20) {
      return '🌟';
    } else {
      return '🚀';
    }
  }
}