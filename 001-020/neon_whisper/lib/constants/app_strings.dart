// File untuk menyimpan semua string constants
// Memudahkan maintenance dan internationalization di masa depan

/// Class untuk menyimpan semua text string yang digunakan di aplikasi
/// 
/// Menggunakan constant constructor untuk performa lebih baik
/// dan mencegah instansiasi yang tidak perlu
class AppStrings {
  // Private constructor untuk mencegah instansiasi class ini
  // Karena ini hanya container untuk constants
  const AppStrings._();

  // Greeting text utama
  static const String mainGreeting = 'Hello';
  
  // Subtext atau tagline
  static const String subGreeting = 'NeonWhisper';
  
  // Message tambahan
  static const String welcomeMessage = 'Welcome to the Synthwave Future';
}