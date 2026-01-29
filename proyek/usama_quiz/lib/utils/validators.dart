class Validators {
  /// Validate username
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (value.length > 20) {
      return 'Username must be less than 20 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    return null;
  }

  /// Validate email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(pattern).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Validate number
  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Number cannot be empty';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Please enter a valid number';
    }
    return null;
  }

  /// Check if username exists (would need database)
  static Future<bool> checkUsernameExists(String username) async {
    // TODO: Implement database check
    await Future.delayed(const Duration(milliseconds: 500));
    return false;
  }

  /// Check if string is valid JSON
  static bool isValidJson(String str) {
    try {
      // ignore: unused_local_variable
      var _ = str; // We could parse here
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Validate level number
  static String? validateLevel(int level) {
    if (level < 1 || level > 200) {
      return 'Level must be between 1 and 200';
    }
    return null;
  }

  /// Check if score is valid
  static bool isValidScore(int score, int total) {
    return score >= 0 && score <= total && total > 0;
  }
}

class ValidationMessages {
  static const String errorEmptyField = 'This field cannot be empty';
  static const String errorInvalidFormat = 'Invalid format';
  static const String errorTooShort = 'Input is too short';
  static const String errorTooLong = 'Input is too long';
  static const String errorInvalidEmail = 'Invalid email address';
  static const String errorPasswordMismatch = 'Passwords do not match';
  static const String errorSpecialCharacters =
      'Special characters are not allowed';
  static const String errorNumbersOnly = 'Only numbers are allowed';
  static const String errorSuccess = 'Success!';
}