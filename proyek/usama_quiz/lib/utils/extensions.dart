import 'package:flutter/material.dart';
import 'dart:math';

// ============= STRING EXTENSIONS =============
extension StringExtensions on String {
  /// Capitalize first letter of string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Remove extra spaces
  String removeExtraSpaces() {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Check if string is Japanese (Hiragana, Katakana, Kanji)
  bool isJapanese() {
    RegExp japaneseRegex =
        RegExp(r'[\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FFF]');
    return japaneseRegex.hasMatch(this);
  }

  /// Check if string is Hiragana
  bool isHiragana() {
    RegExp hiraganaRegex = RegExp(r'[\u3040-\u309F]');
    return hiraganaRegex.hasMatch(this) && !contains(RegExp(r'[\u30A0-\u30FF]'));
  }

  /// Check if string is Katakana
  bool isKatakana() {
    RegExp katakanaRegex = RegExp(r'[\u30A0-\u30FF]');
    return katakanaRegex.hasMatch(this) && !contains(RegExp(r'[\u3040-\u309F]'));
  }

  /// Check if string is Kanji
  bool isKanji() {
    RegExp kanjiRegex = RegExp(r'[\u4E00-\u9FFF]');
    return kanjiRegex.hasMatch(this);
  }

  /// Get font family based on content
  String getFontFamily() {
    if (isJapanese()) {
      return 'Noto Sans JP';
    }
    return 'Inter';
  }

  /// Reverse string
  String reverse() => split('').reversed.join('');

  /// Check if string contains only digits
  bool isNumeric() => RegExp(r'^[0-9]+$').hasMatch(this);

  /// Check if string contains only letters
  bool isAlphabetic() => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Check if string is valid email
  bool isValidEmail() {
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    return RegExp(pattern).hasMatch(this);
  }

  /// Truncate string with ellipsis
  String truncate(int length, {String ellipsis = '...'}) {
    if (this.length <= length) return this;
    return '${substring(0, length)}$ellipsis';
  }

  /// Convert string to slug (lowercase, replace spaces with hyphens)
  String toSlug() {
    return toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .trim()
        .replaceAll(RegExp(r'[-\s]+'), '-');
  }

  /// Convert to title case
  String toTitleCase() {
    return split(' ')
        .map((word) => word.isEmpty
            ? ''
            : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
        .join(' ');
  }

  /// Check if string is palindrome
  bool isPalindrome() {
    final cleaned = replaceAll(RegExp(r'\s'), '').toLowerCase();
    return cleaned == cleaned.split('').reversed.join('');
  }
}

// ============= INT EXTENSIONS =============
extension IntExtensions on int {
  /// Format number with thousand separator
  String toFormattedString() {
    return toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)},',
    );
  }

  /// Get ordinal suffix (1st, 2nd, 3rd, etc)
  String toOrdinal() {
    if (this % 100 >= 11 && this % 100 <= 13) {
      return '${this}th';
    }
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }

  /// Check if number is even
  bool get isEven => this % 2 == 0;

  /// Check if number is odd
  bool get isOdd => this % 2 != 0;

  /// Check if number is positive
  bool get isPositive => this > 0;

  /// Check if number is negative
  bool get isNegative => this < 0;

  /// Get absolute value
  int get abs => this.abs();

  /// Repeat string N times
  String repeatString(String str) => List<String>.filled(this, str).join();

  /// Convert to binary string
  String toBinary() => toRadixString(2);

  /// Convert to hexadecimal string
  String toHex() => toRadixString(16).toUpperCase();

  /// Get factorial
  int get factorial {
    if (this < 0) throw ArgumentError('Factorial of negative number');
    if (this == 0 || this == 1) return 1;
    return this * (this - 1);
  }

  /// Check if prime number
  bool get isPrime {
    if (this < 2) return false;
    if (this == 2) return true;
    if (isEven) return false;
    for (int i = 3; i * i <= this; i += 2) {
      if (this % i == 0) return false;
    }
    return true;
  }

  /// Convert milliseconds to Duration
  Duration get millisecondsDuration => Duration(milliseconds: this);

  /// Convert seconds to Duration
  Duration get secondsDuration => Duration(seconds: this);

  /// Convert minutes to Duration
  Duration get minutesDuration => Duration(minutes: this);

  /// Convert hours to Duration
  Duration get hoursDuration => Duration(hours: this);

  /// Convert days to Duration
  Duration get daysDuration => Duration(days: this);
}

// ============= DOUBLE EXTENSIONS =============
extension DoubleExtensions on double {
  /// Round to N decimal places
  double roundToNDecimalPlaces(int n) {
    int fac = pow(10, n).toInt();
    return (this * fac).round() / fac;
  }

  /// Format percentage
  String toPercentageString({int decimals = 1}) {
    return '${toStringAsFixed(decimals)}%';
  }

  /// Check if number is positive
  bool get isPositive => this > 0;

  /// Check if number is negative
  bool get isNegative => this < 0;

  /// Check if number is zero
  bool get isZero => this == 0;

  /// Get absolute value
  double get abs => this.abs();

  /// Ceiling value
  int get ceil => this.ceil();

  /// Floor value
  int get floor => this.floor();

  /// Round value
  int get round => this.round();

  /// Convert to Currency format
  String toCurrency({String symbol = '\$', int decimals = 2}) {
    return '$symbol${toStringAsFixed(decimals)}';
  }

  /// Clamp between min and max
  double clamp(double min, double max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Linear interpolation
  double lerp(double b, double t) => this + (b - this) * t;
}

// ============= DATETIME EXTENSIONS =============
extension DateTimeExtensions on DateTime {
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Get formatted date string (e.g., "Jan 15, 2024")
  String toFormattedString() {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[month - 1]} $day, $year';
  }

  /// Get time ago string (e.g., "2 hours ago")
  String toTimeAgoString() {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inDays > 365) {
      return '${(diff.inDays / 365).floor()} year${(diff.inDays / 365).floor() > 1 ? 's' : ''} ago';
    } else if (diff.inDays > 30) {
      return '${(diff.inDays / 30).floor()} month${(diff.inDays / 30).floor() > 1 ? 's' : ''} ago';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }

  /// Get formatted time (e.g., "14:30")
  String toFormattedTime() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Get formatted date and time
  String toFormattedDateTime() {
    return '${toFormattedString()} ${toFormattedTime()}';
  }

  /// Check if date is in same year
  bool isSameYear(DateTime other) {
    return year == other.year;
  }

  /// Check if date is in same month
  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  /// Check if date is in same day
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Get start of day
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  /// Get start of month
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Get end of month
  DateTime get endOfMonth => DateTime(year, month + 1, 0);

  /// Get start of year
  DateTime get startOfYear => DateTime(year, 1, 1);

  /// Get end of year
  DateTime get endOfYear => DateTime(year + 1, 1, 0);

  /// Get day name
  String get dayName {
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[weekday - 1];
  }

  /// Get month name
  String get monthName {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  /// Add days
  DateTime addDays(int days) => add(Duration(days: days));

  /// Add hours
  DateTime addHours(int hours) => add(Duration(hours: hours));

  /// Add minutes
  DateTime addMinutes(int minutes) => add(Duration(minutes: minutes));

  /// Subtract days
  DateTime subtractDays(int days) => subtract(Duration(days: days));

  /// Subtract hours
  DateTime subtractHours(int hours) => subtract(Duration(hours: hours));

  /// Subtract minutes
  DateTime subtractMinutes(int minutes) => subtract(Duration(minutes: minutes));
}

// ============= LIST EXTENSIONS =============
extension ListExtensions<T> on List<T> {
  /// Shuffle list without modifying original
  List<T> shuffledCopy(Random random) {
    final list = [...this];
    list.shuffle(random);
    return list;
  }

  /// Get random item from list
  T? getRandomItem(Random random) {
    if (isEmpty) return null;
    return this[random.nextInt(length)];
  }

  /// Get random items (N items)
  List<T> getRandomItems(int count, Random random) {
    if (isEmpty) return [];
    final result = <T>[];
    final copy = [...this];
    count = count > copy.length ? copy.length : count;
    for (int i = 0; i < count; i++) {
      final randomIndex = random.nextInt(copy.length);
      result.add(copy[randomIndex]);
      copy.removeAt(randomIndex);
    }
    return result;
  }

  /// Group items by condition
  Map<bool, List<T>> partition(bool Function(T) test) {
    final trueList = <T>[];
    final falseList = <T>[];
    for (final item in this) {
      if (test(item)) {
        trueList.add(item);
      } else {
        falseList.add(item);
      }
    }
    return {true: trueList, false: falseList};
  }

  /// Chunk list into smaller lists
  List<List<T>> chunk(int size) {
    if (size <= 0) throw ArgumentError('Size must be greater than 0');
    final result = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      result.add(sublist(
          i, i + size > length ? length : i + size));
    }
    return result;
  }

  /// Get first N items
  List<T> first(int n) {
    if (n < 0) throw ArgumentError('N must be >= 0');
    return take(n).toList();
  }

  /// Get last N items
  List<T> last(int n) {
    if (n < 0) throw ArgumentError('N must be >= 0');
    return skip(length > n ? length - n : 0).toList();
  }

  /// Remove duplicates
  List<T> get unique => toSet().toList();

  /// Remove null values
  List<T> get nonNull => where((e) => e != null).toList();

  /// Reverse without modifying original
  List<T> get reversedCopy => reversed.toList();

  /// Flatten nested list (one level)
  List<T> flatten() {
    final result = <T>[];
    for (final item in this) {
      if (item is List) {
        result.addAll(item as List<T>);
      } else {
        result.add(item);
      }
    }
    return result;
  }

  /// Find index of item
  int indexOf(T item) {
    for (int i = 0; i < length; i++) {
      if (this[i] == item) return i;
    }
    return -1;
  }

  /// Check if contains item
  bool containsItem(T item) => indexOf(item) >= 0;

  /// Sum (for int/double lists)
  dynamic sum() {
    if (isEmpty) return 0;
    if (first is int) {
      return fold<int>(0, (a, b) => a + (b as int));
    } else if (first is double) {
      return fold<double>(0.0, (a, b) => a + (b as double));
    }
    return 0;
  }

  /// Average (for int/double lists)
  dynamic average() {
    if (isEmpty) return 0;
    return sum() / length;
  }
}

// ============= MAP EXTENSIONS =============
extension MapExtensions<K, V> on Map<K, V> {
  /// Get value or default
  V? getOrDefault(K key, V defaultValue) {
    return this[key] ?? defaultValue;
  }

  /// Check if key exists
  bool hasKey(K key) => containsKey(key);

  /// Check if value exists
  bool hasValue(V value) => containsValue(value);

  /// Get keys as list
  List<K> get keysList => keys.toList();

  /// Get values as list
  List<V> get valuesList => values.toList();

  /// Merge with another map
  Map<K, V> merge(Map<K, V> other) {
    final result = {...this};
    result.addAll(other);
    return result;
  }

  /// Filter by key
  Map<K, V> filterByKey(bool Function(K) test) {
    final result = <K, V>{};
    forEach((k, v) {
      if (test(k)) result[k] = v;
    });
    return result;
  }

  /// Filter by value
  Map<K, V> filterByValue(bool Function(V) test) {
    final result = <K, V>{};
    forEach((k, v) {
      if (test(v)) result[k] = v;
    });
    return result;
  }
}

// ============= CONTEXT EXTENSIONS =============
extension ContextExtensions on BuildContext {
  /// Show snackbar easily
  void showSnack(String message,
      {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }

  /// Push route
  Future<T?> pushRoute<T extends Object?>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Replace route
  Future<T?> replaceRoute<T extends Object?>(Widget page) {
    return Navigator.of(this).pushReplacement<T, T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Pop route
  void popRoute<T extends Object?>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  /// Pop multiple routes
  void popUntilRoute(String routeName) {
    Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  }

  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Get device orientation
  Orientation get orientation => MediaQuery.of(this).orientation;

  /// Check if landscape
  bool get isLandscape => orientation == Orientation.landscape;

  /// Check if portrait
  bool get isPortrait => orientation == Orientation.portrait;

  /// Get device padding (safe area)
  EdgeInsets get devicePadding => MediaQuery.of(this).padding;

  /// Get keyboard visibility
  bool get isKeyboardVisible =>
      MediaQuery.of(this).viewInsets.bottom > 0;

  /// Get theme data
  ThemeData get theme => Theme.of(this);

  /// Get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get primary color
  Color get primaryColor => Theme.of(this).primaryColor;
}

// ============= DURATION EXTENSIONS =============
extension DurationExtensions on Duration {
  /// Format duration as string (e.g., "2:30:45")
  String toFormattedString() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Format duration as short string (e.g., "2h 30m")
  String toShortString() {
    if (inHours > 0) {
      final minutes = inMinutes.remainder(60);
      return '${inHours}h ${minutes}m';
    } else if (inMinutes > 0) {
      final seconds = inSeconds.remainder(60);
      return '${inMinutes}m ${seconds}s';
    } else {
      return '${inSeconds}s';
    }
  }

  /// Get days
  int get days => inDays;

  /// Get hours
  int get hours => inHours;

  /// Get minutes
  int get minutes => inMinutes;

  /// Get seconds
  int get seconds => inSeconds;

  /// Get milliseconds
  int get milliseconds => inMilliseconds;

  /// Add duration
  Duration plus(Duration other) => this + other;

  /// Subtract duration
  Duration minus(Duration other) => this - other;

  /// Multiply duration
  Duration multiply(int factor) => Duration(microseconds: inMicroseconds * factor);

  /// Check if duration is zero
  bool get isZero => inMicroseconds == 0;

  /// Check if duration is positive
  bool get isPositive => inMicroseconds > 0;

  /// Check if duration is negative
  bool get isNegative => inMicroseconds < 0;
}