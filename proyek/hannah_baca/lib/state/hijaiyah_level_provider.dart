import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/hijaiyah/hijaiyah_generator.dart';
import '../data/hijaiyah/hijaiyah_page_data.dart';

final hijaiyahPagesProvider = Provider.family<List<HijaiyahPageData>, int>(
  (ref, level) => HijaiyahGenerator.generatePages(level),
);