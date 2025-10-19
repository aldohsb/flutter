// ============================================================================
// FILE: lib/models/weather_model.dart
// FUNGSI: Model data untuk menyimpan informasi cuaca
// ============================================================================

// ============================================================================
// WEATHER MODEL CLASS
// ============================================================================
// Class ini digunakan untuk membawa data cuaca dari satu tempat ke tempat
// lain dalam aplikasi. Mirip seperti tas yang membawa barang-barang tertentu.

class WeatherModel {
  // Properti - karakteristik cuaca
  final String condition;        // Kondisi: "sunny", "cloudy", "rainy"
  final int temperature;         // Suhu dalam Celsius
  final String location;         // Lokasi
  final int humidity;            // Kelembaban (0-100%)
  final double windSpeed;        // Kecepatan angin dalam km/h
  final String description;      // Deskripsi cuaca

  // Constructor - fungsi untuk membuat instance WeatherModel
  // Parameter dengan required berarti harus diberikan saat membuat object
  WeatherModel({
    required this.condition,
    required this.temperature,
    required this.location,
    required this.humidity,
    required this.windSpeed,
    required this.description,
  });

  // =========================================================================
  // FACTORY CONSTRUCTOR - Membuat instance dari data tertentu
  // =========================================================================
  // Ini adalah cara lain untuk membuat object WeatherModel dengan data
  // yang sudah ditentukan sebelumnya (hardcoded)

  // Factory untuk cuaca cerah
  factory WeatherModel.sunny() {
    return WeatherModel(
      condition: 'sunny',
      temperature: 28,
      location: 'Jakarta, Indonesia',
      humidity: 65,
      windSpeed: 5.2,
      description: 'Cerah dan hangat',
    );
  }

  // Factory untuk cuaca berawan
  factory WeatherModel.cloudy() {
    return WeatherModel(
      condition: 'cloudy',
      temperature: 24,
      location: 'Jakarta, Indonesia',
      humidity: 72,
      windSpeed: 8.1,
      description: 'Berawan sepanjang hari',
    );
  }

  // Factory untuk cuaca hujan
  factory WeatherModel.rainy() {
    return WeatherModel(
      condition: 'rainy',
      temperature: 22,
      location: 'Jakarta, Indonesia',
      humidity: 88,
      windSpeed: 12.5,
      description: 'Hujan ringan',
    );
  }

  // =========================================================================
  // METHOD - Fungsi yang bisa dilakukan oleh object ini
  // =========================================================================

  // Method untuk mendapatkan emoji yang sesuai dengan kondisi cuaca
  String getEmoji() {
    switch (condition) {
      case 'sunny':
        return '☀️';  // Sun emoji
      case 'cloudy':
        return '☁️';  // Cloud emoji
      case 'rainy':
        return '🌧️';  // Rain emoji
      default:
        return '🌤️';  // Default partly cloudy
    }
  }

  // Method untuk mendapatkan deskripsi kondisi dalam bahasa Indonesia
  String getConditionLabel() {
    switch (condition) {
      case 'sunny':
        return 'Cerah';
      case 'cloudy':
        return 'Berawan';
      case 'rainy':
        return 'Hujan';
      default:
        return 'Tidak Diketahui';
    }
  }

  // =========================================================================
  // METHOD UNTUK DEBUGGING
  // =========================================================================
  // Override method toString() - untuk melihat data dengan mudah di console

  @override
  String toString() {
    return 'WeatherModel(condition: $condition, temp: $temperature°C, location: $location)';
  }
}