class AppConstants {
  // Transaction Types
  static const String typeIncome = 'income';
  static const String typeExpense = 'expense';
  
  // Default Categories for Income
  static const List<Map<String, dynamic>> incomeCategories = [
    {'name': 'Penjualan', 'icon': '💰', 'color': 0xFF26DE81},
    {'name': 'Investasi', 'icon': '📈', 'color': 0xFF4ECDC4},
    {'name': 'Lainnya', 'icon': '💵', 'color': 0xFF95E1D3},
  ];
  
  // Default Categories for Expense
  static const List<Map<String, dynamic>> expenseCategories = [
    {'name': 'Belanja Stok', 'icon': '🛒', 'color': 0xFFFC5C65},
    {'name': 'Gaji Karyawan', 'icon': '👥', 'color': 0xFFFF6B6B},
    {'name': 'Sewa Tempat', 'icon': '🏠', 'color': 0xFFFF7675},
    {'name': 'Listrik & Air', 'icon': '💡', 'color': 0xFFFFBE76},
    {'name': 'Transport', 'icon': '🚗', 'color': 0xFFFECE2E},
    {'name': 'Marketing', 'icon': '📢', 'color': 0xFFFFA502},
    {'name': 'Operasional', 'icon': '⚙️', 'color': 0xFFFF6348},
    {'name': 'Lainnya', 'icon': '📦', 'color': 0xFFDFE4EA},
  ];
  
  // Date Format
  static const String dateFormat = 'dd MMM yyyy';
  static const String monthYearFormat = 'MMMM yyyy';
  
  // Currency
  static const String currency = 'Rp';
  
  // Empty State Messages
  static const String emptyTransactionTitle = 'Belum Ada Transaksi';
  static const String emptyTransactionMessage = 'Yuk mulai catat transaksi pertamamu!';
  
  // Chart Settings
  static const int maxChartBars = 7;
}