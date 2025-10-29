import 'dart:io';
import 'package:csv/csv.dart';
import 'package:ketopedia/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/weight_entry_model.dart';
import '../models/user_model.dart';
import '../utils/helpers.dart';

class ExportService {
  static final ExportService instance = ExportService._();

  ExportService._();

  Future<File> exportWeightData(
    UserModel user,
    List<WeightEntryModel> entries,
  ) async {
    // Prepare CSV data
    List<List<dynamic>> rows = [];

    // Add header
    rows.add([
      'Tanggal',
      'Berat (kg)',
      'Catatan',
    ]);

    // Add user info
    rows.add([]);
    rows.add(['Info Pengguna']);
    rows.add(['Nama', user.name]);
    rows.add(['Jenis Kelamin', user.gender.displayName]);
    rows.add(['Tinggi', '${user.height} cm']);
    rows.add(['Berat Target', Helpers.formatWeight(user.targetWeight)]);
    rows.add(['Tanggal Mulai', Helpers.formatDate(user.startDate)]);
    rows.add(['BMI Saat Ini', Helpers.formatBMI(user.bmi)]);
    rows.add(['Kategori BMI', user.bmiCategory]);
    rows.add([]);

    // Add weight entries header
    rows.add(['Riwayat Berat Badan']);
    rows.add([
      'Tanggal',
      'Berat (kg)',
      'Perubahan (kg)',
      'Catatan',
    ]);

    // Add weight entries
    double? previousWeight;
    for (final entry in entries.reversed) {
      final change = previousWeight != null 
          ? (entry.weight - previousWeight).toStringAsFixed(1)
          : '-';
      
      rows.add([
        Helpers.formatDate(entry.date, format: 'dd/MM/yyyy'),
        entry.weight.toStringAsFixed(1),
        change,
        entry.notes ?? '',
      ]);
      
      previousWeight = entry.weight;
    }

    // Add summary
    if (entries.isNotEmpty) {
      rows.add([]);
      rows.add(['Ringkasan']);
      final firstEntry = entries.last;
      final lastEntry = entries.first;
      final totalChange = lastEntry.weight - firstEntry.weight;
      final daysElapsed = Helpers.getDaysDifference(
        firstEntry.date,
        lastEntry.date,
      );
      final avgChangePerWeek = daysElapsed > 0
          ? (totalChange / daysElapsed) * 7
          : 0.0;

      rows.add(['Berat Awal', Helpers.formatWeight(firstEntry.weight)]);
      rows.add(['Berat Akhir', Helpers.formatWeight(lastEntry.weight)]);
      rows.add(['Total Perubahan', '${totalChange.toStringAsFixed(1)} kg']);
      rows.add(['Durasi', '$daysElapsed hari']);
      rows.add([
        'Rata-rata per Minggu',
        '${avgChangePerWeek.toStringAsFixed(2)} kg',
      ]);
    }

    // Convert to CSV
    String csv = const ListToCsvConverter().convert(rows);

    // Save to file
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = '${directory.path}/ketopedia_weight_data_$timestamp.csv';
    final file = File(path);
    await file.writeAsString(csv);

    return file;
  }

  Future<void> shareWeightData(
    UserModel user,
    List<WeightEntryModel> entries,
  ) async {
    final file = await exportWeightData(user, entries);
    
    await Share.shareXFiles(
      [XFile(file.path)],
      subject: 'Data Berat Badan - Ketopedia',
      text: 'Export data tracking berat badan dari aplikasi Ketopedia',
    );
  }

  Future<String> getExportDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<List<FileSystemEntity>> getExportedFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory.listSync();
    
    return files
        .where((file) => file.path.contains('ketopedia_weight_data'))
        .toList()
      ..sort((a, b) => b.path.compareTo(a.path)); // Sort by newest first
  }

  Future<void> deleteExportedFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> deleteAllExportedFiles() async {
    final files = await getExportedFiles();
    for (final file in files) {
      await File(file.path).delete();
    }
  }
}