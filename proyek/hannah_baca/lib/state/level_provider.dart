import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/generators/level_generator.dart';
import '../data/models/page_data.dart';

final levelPagesProvider = Provider.family<List<PageData>, int>((ref, level) {
  return LevelGenerator.generatePages(level);
});