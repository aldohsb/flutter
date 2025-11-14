import 'package:flutter/material.dart';
import 'package:notepad_pro/models/folder_model.dart';
import 'package:notepad_pro/utils/constants.dart';
import 'package:notepad_pro/theme/app_theme.dart';

class FolderItem extends StatelessWidget {
  final FolderModel folder;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const FolderItem({
    super.key,
    required this.folder,
    required this.isSelected,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingM,
        vertical: AppConstants.spacingXS,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(AppConstants.radiusS),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingM,
              vertical: AppConstants.spacingS,
            ),
            decoration: BoxDecoration(
              color: isSelected 
                  ? folder.color.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
              border: isSelected
                  ? Border.all(
                      color: folder.color.withOpacity(0.3),
                      width: 2,
                    )
                  : null,
            ),
            child: Row(
              children: [
                // Tab indicator (paper-inspired)
                if (isSelected)
                  Container(
                    width: 4,
                    height: 40,
                    margin: const EdgeInsets.only(right: AppConstants.spacingM),
                    decoration: AppTheme.tabDecoration(folder.color),
                  ),
                
                // Folder icon
                Container(
                  padding: const EdgeInsets.all(AppConstants.spacingS),
                  decoration: BoxDecoration(
                    color: folder.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                  ),
                  child: Icon(
                    folder.getIconData(),
                    color: folder.color,
                    size: 24,
                  ),
                ),
                
                const SizedBox(width: AppConstants.spacingM),
                
                // Folder name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        folder.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: isSelected 
                              ? FontWeight.w600 
                              : FontWeight.w500,
                          color: isSelected 
                              ? folder.color
                              : AppTheme.inkBlack,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${folder.noteCount} note${folder.noteCount != 1 ? 's' : ''}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.inkBlue.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Chevron indicator
                if (isSelected)
                  Icon(
                    Icons.chevron_right,
                    color: folder.color,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}