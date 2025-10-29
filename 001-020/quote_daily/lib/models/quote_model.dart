// File: lib/models/quote_model.dart

// Model adalah "blueprint" atau cetakan untuk data kita
// Seperti form yang harus diisi: nama, umur, alamat
// Di sini kita bikin cetakan untuk data Quote

class QuoteModel {
  // Properties (isi data) dari Quote
  final String id;        // ID unik quote
  final String content;   // Isi quote-nya
  final String author;    // Siapa yang ngomong
  final List<String> tags; // Kategori quote (motivasi, cinta, dll)
  
  // Constructor - fungsi untuk bikin Quote baru
  // "required" artinya wajib diisi
  QuoteModel({
    required this.id,
    required this.content,
    required this.author,
    required this.tags,
  });

  // Factory constructor untuk membuat Quote dari JSON
  // JSON adalah format data dari internet, bentuknya kayak dictionary
  // Contoh: {"id": "123", "content": "Be yourself", "author": "Oscar Wilde"}
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      // Ambil value dari json pakai key-nya
      id: json['_id'] ?? '',  // ?? '' artinya: kalau null, pakai string kosong
      content: json['content'] ?? 'No content',
      author: json['author'] ?? 'Unknown',
      // json['tags'] bentuknya List, tapi bisa jadi null
      // Kalau null, kita kasih List kosong []
      tags: json['tags'] != null 
          ? List<String>.from(json['tags']) 
          : [],
    );
  }

  // Method untuk convert Quote ke JSON (kebalikan dari fromJson)
  // Berguna untuk save data ke local storage
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'author': author,
      'tags': tags,
    };
  }

  // Override toString untuk print Quote dengan format bagus
  // Berguna untuk debugging
  @override
  String toString() {
    return 'Quote: "$content" - $author';
  }

  // Method untuk copy Quote dengan beberapa property yang diganti
  // Berguna kalau mau bikin versi baru dari Quote yang sudah ada
  QuoteModel copyWith({
    String? id,
    String? content,
    String? author,
    List<String>? tags,
  }) {
    return QuoteModel(
      id: id ?? this.id,  // Kalau id baru ada, pakai yang baru. Kalau enggak, pakai yang lama
      content: content ?? this.content,
      author: author ?? this.author,
      tags: tags ?? this.tags,
    );
  }
}