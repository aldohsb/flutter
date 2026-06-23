import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Menampilkan satu section insights (misalnya "Panduan Karir") sebagai
/// kartu yang bisa diperluas/diciutkan (expandable), dengan ikon, judul,
/// warna aksen, dan daftar item poin-poin di dalamnya.
class InsightsSection extends StatefulWidget {
  const InsightsSection({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.items,
    required this.accentColor,
    this.initiallyExpanded = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final List<String> items;
  final Color accentColor;
  final bool initiallyExpanded;

  @override
  State<InsightsSection> createState() => _InsightsSectionState();
}

class _InsightsSectionState extends State<InsightsSection>
    with SingleTickerProviderStateMixin {
  late bool _expanded;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: _expanded ? 1.0 : 0.0,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // ── Header (selalu terlihat, bisa ditekan) ───────────────────
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: widget.accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(widget.icon, color: widget.accentColor, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Konten expandable ─────────────────────────────────────────
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Column(
              children: [
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                  child: Column(
                    children: widget.items.asMap().entries.map((entry) {
                      final isLast = entry.key == widget.items.length - 1;
                      return Padding(
                        padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                        child: _InsightItem(
                          text: entry.value,
                          accentColor: widget.accentColor,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightItem extends StatelessWidget {
  const _InsightItem({
    required this.text,
    required this.accentColor,
  });

  final String text;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: accentColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13.5,
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }
}