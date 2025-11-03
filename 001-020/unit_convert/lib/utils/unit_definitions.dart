// File ini berisi definisi semua unit yang tersedia
// Seperti database unit yang bisa kita gunakan di aplikasi

import 'package:flutter/material.dart';
import '../models/unit_category.dart';
import '../models/unit_item.dart';
import '../constants/app_colors.dart';

class UnitDefinitions {
  // Private constructor
  UnitDefinitions._();

  // Daftar semua kategori yang tersedia
  static final List<UnitCategory> categories = [
    const UnitCategory(
      type: UnitCategoryType.length,
      name: 'Length',
      nameBahasa: 'Panjang',
      icon: Icons.straighten,
      color: AppColors.lengthColor,
    ),
    const UnitCategory(
      type: UnitCategoryType.weight,
      name: 'Weight',
      nameBahasa: 'Berat',
      icon: Icons.fitness_center,
      color: AppColors.weightColor,
    ),
    const UnitCategory(
      type: UnitCategoryType.temperature,
      name: 'Temperature',
      nameBahasa: 'Suhu',
      icon: Icons.thermostat,
      color: AppColors.temperatureColor,
    ),
    const UnitCategory(
      type: UnitCategoryType.currency,
      name: 'Currency',
      nameBahasa: 'Mata Uang',
      icon: Icons.attach_money,
      color: AppColors.currencyColor,
    ),
    const UnitCategory(
      type: UnitCategoryType.area,
      name: 'Area',
      nameBahasa: 'Luas',
      icon: Icons.crop_square,
      color: AppColors.primary,
    ),
    const UnitCategory(
      type: UnitCategoryType.volume,
      name: 'Volume',
      nameBahasa: 'Volume',
      icon: Icons.water_drop,
      color: AppColors.accent,
    ),
    const UnitCategory(
      type: UnitCategoryType.speed,
      name: 'Speed',
      nameBahasa: 'Kecepatan',
      icon: Icons.speed,
      color: AppColors.warning,
    ),
    const UnitCategory(
      type: UnitCategoryType.time,
      name: 'Time',
      nameBahasa: 'Waktu',
      icon: Icons.access_time,
      color: AppColors.success,
    ),
  ];

  // Map yang menyimpan daftar unit untuk setiap kategori
  // Map seperti dictionary: key => value
  static final Map<UnitCategoryType, List<UnitItem>> units = {
    // PANJANG - Base unit: Meter
    UnitCategoryType.length: [
      const UnitItem(name: 'Kilometer', symbol: 'km', conversionFactor: 1000),
      const UnitItem(name: 'Meter', symbol: 'm', conversionFactor: 1),
      const UnitItem(name: 'Centimeter', symbol: 'cm', conversionFactor: 0.01),
      const UnitItem(name: 'Millimeter', symbol: 'mm', conversionFactor: 0.001),
      const UnitItem(name: 'Mile', symbol: 'mi', conversionFactor: 1609.34),
      const UnitItem(name: 'Yard', symbol: 'yd', conversionFactor: 0.9144),
      const UnitItem(name: 'Foot', symbol: 'ft', conversionFactor: 0.3048),
      const UnitItem(name: 'Inch', symbol: 'in', conversionFactor: 0.0254),
    ],

    // BERAT - Base unit: Gram
    UnitCategoryType.weight: [
      const UnitItem(name: 'Ton', symbol: 't', conversionFactor: 1000000),
      const UnitItem(name: 'Kilogram', symbol: 'kg', conversionFactor: 1000),
      const UnitItem(name: 'Gram', symbol: 'g', conversionFactor: 1),
      const UnitItem(name: 'Milligram', symbol: 'mg', conversionFactor: 0.001),
      const UnitItem(name: 'Pound', symbol: 'lb', conversionFactor: 453.592),
      const UnitItem(name: 'Ounce', symbol: 'oz', conversionFactor: 28.3495),
    ],

    // SUHU - Ini special karena bukan simple multiplication
    // Kita handle di converter provider
    UnitCategoryType.temperature: [
      const UnitItem(name: 'Celsius', symbol: '°C', conversionFactor: 1),
      const UnitItem(name: 'Fahrenheit', symbol: '°F', conversionFactor: 1),
      const UnitItem(name: 'Kelvin', symbol: 'K', conversionFactor: 1),
    ],

    // CURRENCY - Akan diupdate dengan rate real-time dari API
    UnitCategoryType.currency: [
      const UnitItem(name: 'US Dollar', symbol: 'USD', conversionFactor: 1),
      const UnitItem(name: 'Indonesian Rupiah', symbol: 'IDR', conversionFactor: 15000),
      const UnitItem(name: 'Euro', symbol: 'EUR', conversionFactor: 0.85),
      const UnitItem(name: 'British Pound', symbol: 'GBP', conversionFactor: 0.73),
      const UnitItem(name: 'Japanese Yen', symbol: 'JPY', conversionFactor: 110),
      const UnitItem(name: 'Malaysian Ringgit', symbol: 'MYR', conversionFactor: 4.2),
      const UnitItem(name: 'Singapore Dollar', symbol: 'SGD', conversionFactor: 1.35),
    ],

    // LUAS - Base unit: Meter persegi
    UnitCategoryType.area: [
      const UnitItem(name: 'Square Kilometer', symbol: 'km²', conversionFactor: 1000000),
      const UnitItem(name: 'Hectare', symbol: 'ha', conversionFactor: 10000),
      const UnitItem(name: 'Square Meter', symbol: 'm²', conversionFactor: 1),
      const UnitItem(name: 'Square Centimeter', symbol: 'cm²', conversionFactor: 0.0001),
      const UnitItem(name: 'Square Mile', symbol: 'mi²', conversionFactor: 2589988.11),
      const UnitItem(name: 'Square Foot', symbol: 'ft²', conversionFactor: 0.092903),
    ],

    // VOLUME - Base unit: Liter
    UnitCategoryType.volume: [
      const UnitItem(name: 'Cubic Meter', symbol: 'm³', conversionFactor: 1000),
      const UnitItem(name: 'Liter', symbol: 'L', conversionFactor: 1),
      const UnitItem(name: 'Milliliter', symbol: 'mL', conversionFactor: 0.001),
      const UnitItem(name: 'Gallon (US)', symbol: 'gal', conversionFactor: 3.78541),
      const UnitItem(name: 'Quart', symbol: 'qt', conversionFactor: 0.946353),
      const UnitItem(name: 'Cup', symbol: 'cup', conversionFactor: 0.236588),
    ],

    // KECEPATAN - Base unit: Meter per detik
    UnitCategoryType.speed: [
      const UnitItem(name: 'Kilometers/Hour', symbol: 'km/h', conversionFactor: 0.277778),
      const UnitItem(name: 'Meters/Second', symbol: 'm/s', conversionFactor: 1),
      const UnitItem(name: 'Miles/Hour', symbol: 'mph', conversionFactor: 0.44704),
      const UnitItem(name: 'Knot', symbol: 'kn', conversionFactor: 0.514444),
    ],

    // WAKTU - Base unit: Detik
    UnitCategoryType.time: [
      const UnitItem(name: 'Week', symbol: 'week', conversionFactor: 604800),
      const UnitItem(name: 'Day', symbol: 'day', conversionFactor: 86400),
      const UnitItem(name: 'Hour', symbol: 'h', conversionFactor: 3600),
      const UnitItem(name: 'Minute', symbol: 'min', conversionFactor: 60),
      const UnitItem(name: 'Second', symbol: 's', conversionFactor: 1),
      const UnitItem(name: 'Millisecond', symbol: 'ms', conversionFactor: 0.001),
    ],
  };

  // Helper method untuk mendapatkan unit berdasarkan kategori
  static List<UnitItem> getUnitsForCategory(UnitCategoryType category) {
    return units[category] ?? [];
  }

  // Helper method untuk mendapatkan kategori berdasarkan type
  static UnitCategory? getCategoryByType(UnitCategoryType type) {
    try {
      return categories.firstWhere((cat) => cat.type == type);
    } catch (e) {
      return null;
    }
  }
}