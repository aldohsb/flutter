// File ini berisi model/entity untuk ShoppingItem
// Model adalah representasi data dalam bentuk class yang terstruktur
// Class ini mendefinisikan struktur data untuk satu item belanja

// Class ShoppingItem merepresentasikan satu item dalam daftar belanja
// Class ini immutable (menggunakan final fields) untuk data safety
class ShoppingItem {
  // === PROPERTIES ===
  // Field-field yang mendefinisikan karakteristik sebuah shopping item
  
  // id: Unique identifier untuk setiap item
  // String digunakan karena bisa berisi UUID atau kombinasi timestamp
  // final berarti nilai tidak bisa diubah setelah object dibuat (immutability)
  final String id;
  
  // name: Nama item yang akan dibeli (contoh: "Apel", "Susu", "Roti")
  // Ini adalah informasi utama yang akan ditampilkan ke user
  final String name;
  
  // quantity: Jumlah item yang perlu dibeli
  // int karena quantity biasanya berupa angka bulat (1, 2, 3, dst)
  final int quantity;
  
  // unit: Satuan untuk quantity (contoh: "kg", "liter", "buah", "pack")
  // String untuk fleksibilitas berbagai jenis satuan
  final String unit;
  
  // category: Kategori item (contoh: "Sayuran", "Buah", "Dairy", "Snack")
  // Membantu mengorganisir dan mengelompokkan items
  final String category;
  
  // isChecked: Status apakah item sudah dibeli atau belum
  // bool: true = sudah dibeli, false = belum dibeli
  // Ini adalah core functionality untuk checklist
  final bool isChecked;
  
  // createdAt: Timestamp kapan item ditambahkan ke list
  // DateTime menyimpan tanggal dan waktu pembuatan item
  // Berguna untuk sorting atau menampilkan informasi "added 2 hours ago"
  final DateTime createdAt;
  
  // notes: Catatan tambahan untuk item (optional)
  // Nullable (String?) karena tidak semua item butuh notes
  // Contoh notes: "Pilih yang matang", "Merek XYZ", "Jangan lupa kupon"
  final String? notes;

  // === CONSTRUCTOR ===
  // Constructor adalah method special untuk membuat instance ShoppingItem
  // Named parameters dengan {} memungkinkan pemanggilan yang lebih readable
  ShoppingItem({
    // required berarti parameter ini wajib diisi saat membuat object
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
    // isChecked default false karena item baru belum dibeli
    // = false memberikan default value jika tidak dispesifikkan
    this.isChecked = false,
    // createdAt default DateTime.now() (waktu sekarang)
    // Jika tidak dispesifikkan, otomatis pakai waktu pembuatan object
    DateTime? createdAt,
    // notes nullable, default null (tidak ada catatan)
    this.notes,
  }) : createdAt = createdAt ?? DateTime.now();
  // Initializer list (: createdAt = ...) dijalankan sebelum constructor body
  // ?? adalah null-coalescing operator: gunakan createdAt jika ada, kalau null pakai DateTime.now()

  // === COPY WITH METHOD ===
  // Method untuk membuat copy dari object dengan beberapa field yang diubah
  // Ini penting karena object immutable, kita tidak bisa ubah field langsung
  // Pattern ini disebut "copy with" dan sangat umum di Dart/Flutter
  ShoppingItem copyWith({
    // Semua parameters optional (nullable) karena kita hanya update yang perlu
    String? id,
    String? name,
    int? quantity,
    String? unit,
    String? category,
    bool? isChecked,
    DateTime? createdAt,
    String? notes,
  }) {
    // Return new ShoppingItem dengan values yang di-override atau tetap sama
    return ShoppingItem(
      // ?? operator: gunakan new value jika ada, kalau null tetap pakai value lama (this.id)
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      isChecked: isChecked ?? this.isChecked,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
    );
    // Contoh penggunaan: item.copyWith(isChecked: true)
    // Ini membuat object baru dengan semua field sama kecuali isChecked
  }

  // === TO JSON METHOD ===
  // Method untuk convert ShoppingItem object menjadi Map<String, dynamic>
  // Map ini bisa di-serialize menjadi JSON string untuk storage atau network
  Map<String, dynamic> toJson() {
    // Return Map dengan key-value pairs
    return {
      // Key 'id' dengan value dari this.id
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'category': category,
      'isChecked': isChecked,
      // DateTime di-convert ke ISO8601 string format (contoh: "2024-01-15T10:30:00.000")
      // Format ini standard dan mudah di-parse kembali
      'createdAt': createdAt.toIso8601String(),
      'notes': notes,
    };
    // Hasil contoh: {"id": "123", "name": "Apel", "quantity": 2, ...}
  }

  // === FROM JSON FACTORY ===
  // Factory constructor untuk membuat ShoppingItem dari Map (JSON)
  // factory keyword berarti method ini return instance, bukan void
  // Digunakan untuk deserialize data dari storage atau API
  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    // Return new ShoppingItem dengan data dari Map
    return ShoppingItem(
      // json['id'] mengambil value dari key 'id' di Map
      // as String adalah type cast untuk memastikan tipe data benar
      id: json['id'] as String,
      name: json['name'] as String,
      // as int untuk ensure tipe data integer
      quantity: json['quantity'] as int,
      unit: json['unit'] as String,
      category: json['category'] as String,
      // as bool untuk ensure tipe data boolean
      isChecked: json['isChecked'] as bool,
      // DateTime.parse() convert ISO8601 string kembali menjadi DateTime object
      createdAt: DateTime.parse(json['createdAt'] as String),
      // as String? untuk nullable string (boleh null)
      notes: json['notes'] as String?,
    );
    // Contoh input: {"id": "123", "name": "Apel", ...}
    // Output: ShoppingItem object dengan fields terisi
  }

  // === TO STRING METHOD ===
  // Override toString() untuk debugging dan logging yang lebih readable
  // Method ini dipanggil saat kita print() object
  @override
  String toString() {
    // Return string representation yang informative
    return 'ShoppingItem(id: $id, name: $name, quantity: $quantity $unit, '
        'category: $category, isChecked: $isChecked, createdAt: $createdAt, '
        'notes: $notes)';
    // Contoh output: "ShoppingItem(id: 123, name: Apel, quantity: 2 kg, ...)"
    // Sangat helpful saat debugging untuk melihat isi object
  }

  // === EQUALITY OPERATORS ===
  // Override == operator untuk compare dua ShoppingItem objects
  // Penting untuk comparing objects dalam collections atau state management
  @override
  bool operator ==(Object other) {
    // Cek apakah object yang dibandingkan identical (reference sama)
    if (identical(this, other)) return true;
    
    // Cek apakah other adalah ShoppingItem dan id-nya sama
    // runtimeType memastikan kedua object adalah tipe yang sama
    return other is ShoppingItem &&
        other.runtimeType == runtimeType &&
        other.id == id;
    // Kita hanya compare id karena id adalah unique identifier
    // Dua items dengan id sama dianggap sama meski field lain berbeda
  }

  // Override hashCode untuk konsistensi dengan == operator
  // hashCode digunakan oleh collections seperti Set dan Map
  // Objects yang == harus memiliki hashCode yang sama
  @override
  int get hashCode {
    // Menggunakan id.hashCode karena id adalah unique identifier
    return id.hashCode;
    // hashCode penting untuk performance saat object digunakan dalam HashSet atau HashMap
  }

  // === COMPUTED PROPERTIES ===
  // Getter untuk informasi yang di-compute dari existing fields
  
  // displayQuantity: Format quantity dengan unit untuk display
  // Contoh: "2 kg", "5 buah", "1 liter"
  String get displayQuantity {
    // String interpolation untuk combine quantity dan unit
    return '$quantity $unit';
    // Mudah di-display di UI tanpa perlu format manual
  }

  // isNew: Cek apakah item ditambahkan dalam 24 jam terakhir
  // Berguna untuk highlight "new" items di UI
  bool get isNew {
    // DateTime.now() - waktu sekarang
    // difference() menghitung selisih waktu
    // inHours memberikan selisih dalam jam
    final hoursSinceCreated = DateTime.now().difference(createdAt).inHours;
    // Return true jika kurang dari 24 jam
    return hoursSinceCreated < 24;
    // Bisa digunakan untuk badge "NEW" di UI
  }

  // hasNotes: Helper untuk cek apakah item punya notes
  // Lebih readable daripada cek notes != null && notes!.isNotEmpty
  bool get hasNotes {
    // notes != null memastikan notes tidak null
    // notes!.isNotEmpty memastikan notes tidak empty string
    // ! adalah null assertion operator (safe karena sudah cek != null)
    return notes != null && notes!.isNotEmpty;
    // Berguna untuk conditional rendering notes section di UI
  }
}