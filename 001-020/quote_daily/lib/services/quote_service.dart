// File: lib/services/quote_service.dart
// Version: ZenQuotes API

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/quote_model.dart';

class QuoteService {
  // ZenQuotes API - Lebih reliable dari Quotable
  static const String _baseUrl = 'https://zenquotes.io/api';
  
  // Fallback quotes untuk offline mode
  static final List<Map<String, dynamic>> _fallbackQuotes = [
    {
      '_id': '1',
      'content': 'The only way to do great work is to love what you do.',
      'author': 'Steve Jobs',
      'tags': ['inspirational', 'work']
    },
    {
      '_id': '2',
      'content': 'Innovation distinguishes between a leader and a follower.',
      'author': 'Steve Jobs',
      'tags': ['innovation', 'leadership']
    },
    {
      '_id': '3',
      'content': 'Your time is limited, don\'t waste it living someone else\'s life.',
      'author': 'Steve Jobs',
      'tags': ['life', 'inspirational']
    },
    {
      '_id': '4',
      'content': 'Stay hungry, stay foolish.',
      'author': 'Steve Jobs',
      'tags': ['inspirational', 'wisdom']
    },
    {
      '_id': '5',
      'content': 'The future belongs to those who believe in the beauty of their dreams.',
      'author': 'Eleanor Roosevelt',
      'tags': ['future', 'dreams']
    },
    {
      '_id': '6',
      'content': 'It is during our darkest moments that we must focus to see the light.',
      'author': 'Aristotle',
      'tags': ['wisdom', 'inspirational']
    },
    {
      '_id': '7',
      'content': 'Believe you can and you\'re halfway there.',
      'author': 'Theodore Roosevelt',
      'tags': ['motivational', 'belief']
    },
    {
      '_id': '8',
      'content': 'The only impossible journey is the one you never begin.',
      'author': 'Tony Robbins',
      'tags': ['journey', 'motivational']
    },
    {
      '_id': '9',
      'content': 'Life is what happens when you\'re busy making other plans.',
      'author': 'John Lennon',
      'tags': ['life', 'wisdom']
    },
    {
      '_id': '10',
      'content': 'The way to get started is to quit talking and begin doing.',
      'author': 'Walt Disney',
      'tags': ['action', 'motivational']
    },
    {
      '_id': '11',
      'content': 'Don\'t watch the clock; do what it does. Keep going.',
      'author': 'Sam Levenson',
      'tags': ['time', 'persistence']
    },
    {
      '_id': '12',
      'content': 'The best time to plant a tree was 20 years ago. The second best time is now.',
      'author': 'Chinese Proverb',
      'tags': ['wisdom', 'action']
    },
    {
      '_id': '13',
      'content': 'Success is not final, failure is not fatal: it is the courage to continue that counts.',
      'author': 'Winston Churchill',
      'tags': ['success', 'courage']
    },
    {
      '_id': '14',
      'content': 'Everything you\'ve ever wanted is on the other side of fear.',
      'author': 'George Addair',
      'tags': ['fear', 'courage']
    },
    {
      '_id': '15',
      'content': 'Dream big and dare to fail.',
      'author': 'Norman Vaughan',
      'tags': ['dreams', 'courage']
    },
  ];

  final Random _random = Random();

  // Method untuk fetch quote dari ZenQuotes API
  Future<QuoteModel> fetchRandomQuote() async {
    try {
      print('Fetching quote from ZenQuotes API...');
      
      // ZenQuotes endpoint: /random untuk 1 quote random
      final url = Uri.parse('$_baseUrl/random');
      
      // Timeout 10 detik
      final response = await http.get(url).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          print('ZenQuotes API timeout, using fallback');
          throw Exception('Request timeout');
        },
      );

      if (response.statusCode == 200) {
        print('✅ Successfully fetched from ZenQuotes');
        
        // ZenQuotes return array: [{"q": "quote", "a": "author", "h": "html"}]
        final List<dynamic> data = json.decode(response.body);
        
        if (data.isNotEmpty) {
          // Convert format ZenQuotes ke format kita
          final zenQuote = data[0];
          
          // Buat Map dengan format kita
          final quoteData = {
            '_id': DateTime.now().millisecondsSinceEpoch.toString(), // Generate ID unik
            'content': zenQuote['q'] ?? 'No quote', // 'q' = quote text
            'author': zenQuote['a'] ?? 'Unknown', // 'a' = author
            'tags': _generateTagsFromContent(zenQuote['q'] ?? ''), // Generate tags
          };
          
          return QuoteModel.fromJson(quoteData);
        } else {
          throw Exception('Empty response from ZenQuotes');
        }
      } else {
        throw Exception('ZenQuotes API error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ ZenQuotes API failed: $e');
      print('📦 Using fallback local quotes');
      
      // Pakai fallback
      return _getRandomFallbackQuote();
    }
  }

  // Method untuk generate tags dari content
  // ZenQuotes tidak kasih tags, jadi kita bikin sendiri
  List<String> _generateTagsFromContent(String content) {
    final lowercaseContent = content.toLowerCase();
    List<String> tags = [];
    
    // Keyword mapping
    if (lowercaseContent.contains('success') || 
        lowercaseContent.contains('achieve')) {
      tags.add('success');
    }
    if (lowercaseContent.contains('love') || 
        lowercaseContent.contains('heart')) {
      tags.add('love');
    }
    if (lowercaseContent.contains('life') || 
        lowercaseContent.contains('live')) {
      tags.add('life');
    }
    if (lowercaseContent.contains('dream') || 
        lowercaseContent.contains('hope')) {
      tags.add('inspirational');
    }
    if (lowercaseContent.contains('work') || 
        lowercaseContent.contains('effort')) {
      tags.add('motivational');
    }
    if (lowercaseContent.contains('wise') || 
        lowercaseContent.contains('wisdom')) {
      tags.add('wisdom');
    }
    
    // Kalau tidak ada tags, kasih default
    if (tags.isEmpty) {
      tags.add('wisdom');
    }
    
    return tags;
  }

  // Method untuk ambil quote random dari fallback
  QuoteModel _getRandomFallbackQuote() {
    final randomIndex = _random.nextInt(_fallbackQuotes.length);
    final quoteData = _fallbackQuotes[randomIndex];
    return QuoteModel.fromJson(quoteData);
  }

  // Method untuk generate background image URL
  String getBackgroundImageUrl(int index) {
    // Picsum Photos - Alternative dari Unsplash (lebih cepat)
    // Format: https://picsum.photos/width/height?random=seed
    return 'https://picsum.photos/800/1200?random=$index';
  }

  // Method untuk fetch multiple quotes
  Future<List<QuoteModel>> fetchMultipleQuotes({int count = 5}) async {
    try {
      print('Fetching $count quotes from ZenQuotes...');
      
      // ZenQuotes endpoint: /quotes untuk multiple quotes
      // Return 50 quotes
      final url = Uri.parse('$_baseUrl/quotes');
      
      final response = await http.get(url).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );

      if (response.statusCode == 200) {
        print('✅ Successfully fetched multiple quotes');
        
        final List<dynamic> data = json.decode(response.body);
        
        // Ambil sejumlah count dari response
        final selectedQuotes = data.take(count).toList();
        
        // Convert setiap quote
        return selectedQuotes.map((zenQuote) {
          final quoteData = {
            '_id': DateTime.now().millisecondsSinceEpoch.toString() + 
                   _random.nextInt(1000).toString(),
            'content': zenQuote['q'] ?? 'No quote',
            'author': zenQuote['a'] ?? 'Unknown',
            'tags': _generateTagsFromContent(zenQuote['q'] ?? ''),
          };
          return QuoteModel.fromJson(quoteData);
        }).toList();
      } else {
        throw Exception('API error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ API failed: $e');
      print('📦 Using fallback quotes');
      
      return _getMultipleFallbackQuotes(count);
    }
  }

  // Method untuk ambil multiple fallback quotes
  List<QuoteModel> _getMultipleFallbackQuotes(int count) {
    final shuffled = List<Map<String, dynamic>>.from(_fallbackQuotes)
      ..shuffle(_random);
    final selected = shuffled.take(count).toList();
    return selected.map((json) => QuoteModel.fromJson(json)).toList();
  }
}