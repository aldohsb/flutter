// Model untuk menyimpan data intake air
// Model adalah representasi data dalam bentuk class/object

import 'package:hive/hive.dart';

// part directive ini untuk generated code dari hive_generator
// File .g.dart akan dibuat otomatis saat menjalankan build_runner
part 'water_intake.g.dart';

// Annotation @HiveType memberitahu Hive bahwa ini adalah model yang akan disimpan
// typeId adalah ID unik untuk model ini (harus berbeda untuk setiap model)
@HiveType(typeId: 0)
class WaterIntake extends HiveObject {
  // === PROPERTIES/FIELD ===
  
  // @HiveField annotation menandai field mana yang akan disimpan
  // Angka dalam kurung adalah index field (harus unik per class)
  
  // ID unik untuk setiap record intake
  @HiveField(0)
  String id;
  
  // Jumlah air yang diminum dalam mililiter
  @HiveField(1)
  int amountMl;
  
  // Waktu kapan air diminum
  @HiveField(2)
  DateTime timestamp;
  
  // Catatan opsional (misalnya "setelah olahraga", "pagi hari", dll)
  @HiveField(3)
  String? note;

  // === CONSTRUCTOR ===
  
  // Constructor adalah method special untuk membuat instance baru dari class
  // required berarti parameter wajib diisi
  // this.namaField adalah shorthand untuk assign value ke field
  WaterIntake({
    required this.id,
    required this.amountMl,
    required this.timestamp,
    this.note, // nullable (boleh null) karena punya tanda ?
  });

  // === FACTORY CONSTRUCTOR ===
  
  // Factory constructor untuk membuat instance baru dengan ID otomatis
  // Factory method bisa return instance yang sudah ada atau membuat baru
  factory WaterIntake.create({
    required int amountMl,
    String? note,
  }) {
    // DateTime.now() mengambil waktu sekarang
    // millisecondsSinceEpoch mengubah waktu jadi angka unik (timestamp)
    // toString() mengubah angka jadi string untuk dijadikan ID
    return WaterIntake(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amountMl: amountMl,
      timestamp: DateTime.now(),
      note: note,
    );
  }

  // === METHODS ===
  
  // Method untuk mengubah object jadi Map
  // Map seperti dictionary/object di bahasa lain: {key: value}
  // Berguna untuk konversi ke JSON atau format lain
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amountMl': amountMl,
      'timestamp': timestamp.toIso8601String(), // Format waktu standar
      'note': note,
    };
  }

  // Factory constructor untuk membuat instance dari Map
  // Berguna saat membaca data dari JSON atau database
  factory WaterIntake.fromMap(Map<String, dynamic> map) {
    return WaterIntake(
      id: map['id'] as String,
      amountMl: map['amountMl'] as int,
      // DateTime.parse mengubah string waktu jadi object DateTime
      timestamp: DateTime.parse(map['timestamp'] as String),
      note: map['note'] as String?, // bisa null
    );
  }

  // Method untuk copy object dengan beberapa field yang diubah
  // Ini penting karena di Flutter kita sering butuh immutability
  // (tidak mengubah object asli, tapi buat object baru)
  WaterIntake copyWith({
    String? id,
    int? amountMl,
    DateTime? timestamp,
    String? note,
  }) {
    return WaterIntake(
      id: id ?? this.id, // ?? artinya "kalau null, pakai nilai asli"
      amountMl: amountMl ?? this.amountMl,
      timestamp: timestamp ?? this.timestamp,
      note: note ?? this.note,
    );
  }

  // Override toString untuk memudahkan debugging
  // Method ini dipanggil saat kita print(object)
  @override
  String toString() {
    return 'WaterIntake(id: $id, amountMl: $amountMl, timestamp: $timestamp, note: $note)';
  }

  // Override operator == untuk membandingkan 2 object
  // Berguna saat cek apakah 2 object sama atau tidak
  @override
  bool operator ==(Object other) {
    // identical mengecek apakah 2 object adalah object yang sama persis
    if (identical(this, other)) return true;

    // is keyword mengecek tipe data
    // runtimeType mengambil tipe data object
    return other is WaterIntake &&
        other.id == id &&
        other.amountMl == amountMl &&
        other.timestamp == timestamp &&
        other.note == note;
  }

  // Override hashCode untuk konsistensi dengan operator ==
  // hashCode digunakan di collections seperti Set dan Map
  // ^ adalah XOR operator untuk combine hash
  @override
  int get hashCode {
    return id.hashCode ^
        amountMl.hashCode ^
        timestamp.hashCode ^
        note.hashCode;
  }
}