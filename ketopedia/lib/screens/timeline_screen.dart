import 'package:flutter/material.dart';
import '../data/education_data.dart';
import '../utils/constants.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timeline = EducationData.ketoTimeline;

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      itemCount: timeline.length,
      itemBuilder: (context, index) {
        final item = timeline[index];
        final isLast = index == timeline.length - 1;

        return _TimelineItem(
          day: item['day'] as String,
          title: item['title'] as String,
          icon: item['icon'] as String,
          content: item['content'] as String,
          isLast: isLast,
          index: index,
        );
      },
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String day;
  final String title;
  final String icon;
  final String content;
  final bool isLast;
  final int index;

  const _TimelineItem({
    required this.day,
    required this.title,
    required this.icon,
    required this.content,
    required this.isLast,
    required this.index,
  });

  Color get _getColor {
    if (index == 0) return AppConstants.primaryRed;
    if (index == 1 || index == 2) return AppConstants.ratingCareful;
    if (index == 3 || index == 4) return AppConstants.accentYellow;
    return AppConstants.ratingExcellent;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _getColor,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    icon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          _getColor,
                          _getColor.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusSmall,
                          ),
                          border: Border.all(
                            color: _getColor,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          day,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: _getColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        content,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}