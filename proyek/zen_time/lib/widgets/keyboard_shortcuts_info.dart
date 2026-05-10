import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zentime/providers/timer_provider.dart';

class KeyboardShortcutsInfo extends StatelessWidget {
  const KeyboardShortcutsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final timerProvider = context.watch<TimerProvider>();
    final shortcuts = timerProvider.keyboardShortcuts;

    if (!shortcuts.isSupported) {
      return const SizedBox.shrink();
    }

    final shortcutsMap = shortcuts.getShortcutsDescription();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.keyboard,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Keyboard Shortcuts',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...shortcutsMap.entries.map((entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          entry.value,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 8),
            Text(
              shortcuts.isInitialized
                  ? '✓ Shortcuts are active'
                  : '⚠ Shortcuts initialization pending',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: shortcuts.isInitialized
                        ? Colors.green
                        : Colors.orange,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}