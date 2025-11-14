import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notepad_pro/models/note_model.dart';
import 'package:notepad_pro/widgets/tag_chip.dart';
import 'package:notepad_pro/utils/constants.dart';
import 'package:notepad_pro/theme/app_theme.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onDelete;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    this.onFavoriteToggle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy HH:mm');
    
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingM,
        vertical: AppConstants.spacingS,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.spacingM),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
            // Paper-like background
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.paperWhite,
                AppTheme.paperWhite.withOpacity(0.95),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Title and Favorite
              Row(
                children: [
                  Expanded(
                    child: Text(
                      note.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (onFavoriteToggle != null)
                    IconButton(
                      icon: Icon(
                        note.isFavorite ? Icons.star : Icons.star_outline,
                        color: note.isFavorite 
                            ? AppTheme.tabRed 
                            : AppTheme.inkBlue,
                      ),
                      onPressed: onFavoriteToggle,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
              
              const SizedBox(height: AppConstants.spacingS),
              
              // Content preview
              if (note.preview.isNotEmpty)
                Text(
                  note.preview,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.inkBlue.withOpacity(0.7),
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              
              const SizedBox(height: AppConstants.spacingM),
              
              // Tags
              if (note.tags.isNotEmpty)
                Wrap(
                  spacing: AppConstants.spacingS,
                  runSpacing: AppConstants.spacingS,
                  children: note.tags.take(3).map((tag) {
                    return TagChip(
                      label: tag,
                      fontSize: 11,
                    );
                  }).toList(),
                ),
              
              if (note.tags.isNotEmpty)
                const SizedBox(height: AppConstants.spacingS),
              
              // Footer: Date and Actions
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 14,
                    color: AppTheme.inkBlue.withOpacity(0.5),
                  ),
                  const SizedBox(width: AppConstants.spacingXS),
                  Text(
                    dateFormat.format(note.updatedAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.inkBlue.withOpacity(0.5),
                    ),
                  ),
                  const Spacer(),
                  if (onDelete != null)
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: AppTheme.inkBlue.withOpacity(0.5),
                      ),
                      onPressed: onDelete,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}