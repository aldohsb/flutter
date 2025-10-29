import 'package:flutter/material.dart';
import '../data/education_data.dart';
import '../utils/constants.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final comparisons = EducationData.dietComparison;

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      itemCount: comparisons.length,
      itemBuilder: (context, index) {
        final item = comparisons[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppConstants.primaryRed,
                    AppConstants.accentYellow,
                  ],
                ),
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              ),
              child: Center(
                child: Text(
                  item['icon'] as String,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            title: Text(
              item['title'] as String,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContentSection(
                      context,
                      item['content'] as String,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContentSection(BuildContext context, String content) {
    // Parse content untuk highlight Keto vs other diet
    final lines = content.split('\n');
    final widgets = <Widget>[];

    for (final line in lines) {
      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      Widget lineWidget;

      if (line.contains(':')) {
        // Header line
        lineWidget = Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 8),
          child: Text(
            line,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppConstants.primaryRed,
                ),
          ),
        );
      } else if (line.startsWith('•')) {
        // Bullet point
        lineWidget = Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: TextStyle(fontSize: 16)),
              Expanded(
                child: Text(
                  line.substring(1).trim(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      } else if (line.startsWith('🏆') ||
          line.startsWith('💡') ||
          line.startsWith('🔥')) {
        // Emoji highlight
        lineWidget = Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppConstants.accentYellow.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            border: Border.all(
              color: AppConstants.accentYellow.withOpacity(0.3),
            ),
          ),
          child: Text(
            line,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        );
      } else {
        // Regular text
        lineWidget = Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            line,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }

      widgets.add(lineWidget);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}