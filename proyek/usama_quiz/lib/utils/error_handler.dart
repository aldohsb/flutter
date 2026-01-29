import 'package:flutter/material.dart';

class ErrorHandler {
  /// Log error dengan timestamp
  static void logError(
    String source,
    dynamic error, {
    StackTrace? stackTrace,
  }) {
    final timestamp = DateTime.now().toString();
    print('[$timestamp] ERROR in $source: $error');
    if (stackTrace != null) {
      print('StackTrace: $stackTrace');
    }
  }

  /// Show error dialog
  static void showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onRetry,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (onRetry != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onRetry();
              },
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }

  /// Show error snackbar
  static void showErrorSnackBar(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: duration,
      ),
    );
  }

  /// Get user-friendly error message
  static String getUserFriendlyMessage(dynamic error) {
    if (error is String) {
      return error;
    }
    if (error is Exception) {
      return error.toString().replaceAll('Exception: ', '');
    }
    return 'An unexpected error occurred. Please try again.';
  }
}

class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  AppException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException({super.message = 'Network error occurred'})
      : super(code: 'NETWORK_ERROR');
}

class DatabaseException extends AppException {
  DatabaseException({super.message = 'Database error occurred'})
      : super(code: 'DATABASE_ERROR');
}

class ValidationException extends AppException {
  ValidationException({super.message = 'Validation error'})
      : super(code: 'VALIDATION_ERROR');
}