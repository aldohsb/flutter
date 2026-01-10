import 'package:flutter/material.dart';
import 'package:notepad_pro/utils/constants.dart';
import 'package:notepad_pro/theme/app_theme.dart';

enum TextFormatType {
  bold,
  italic,
  underline,
  bulletList,
  numberedList,
  heading,
}

class RichTextToolbar extends StatelessWidget {
  final Function(TextFormatType) onFormatSelected;
  final Set<TextFormatType> activeFormats;

  const RichTextToolbar({
    super.key,
    required this.onFormatSelected,
    this.activeFormats = const {},
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingS,
        vertical: AppConstants.spacingS,
      ),
      decoration: BoxDecoration(
        color: AppTheme.paperWhite,
        border: const Border(
          top: BorderSide(
            color: AppTheme.lineGray,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildToolbarButton(
            context,
            icon: Icons.format_bold,
            type: TextFormatType.bold,
            tooltip: 'Bold',
          ),
          _buildToolbarButton(
            context,
            icon: Icons.format_italic,
            type: TextFormatType.italic,
            tooltip: 'Italic',
          ),
          _buildToolbarButton(
            context,
            icon: Icons.format_underlined,
            type: TextFormatType.underline,
            tooltip: 'Underline',
          ),
          
          const SizedBox(width: AppConstants.spacingS),
          _buildDivider(),
          const SizedBox(width: AppConstants.spacingS),
          
          _buildToolbarButton(
            context,
            icon: Icons.format_list_bulleted,
            type: TextFormatType.bulletList,
            tooltip: 'Bullet List',
          ),
          _buildToolbarButton(
            context,
            icon: Icons.format_list_numbered,
            type: TextFormatType.numberedList,
            tooltip: 'Numbered List',
          ),
          
          const SizedBox(width: AppConstants.spacingS),
          _buildDivider(),
          const SizedBox(width: AppConstants.spacingS),
          
          _buildToolbarButton(
            context,
            icon: Icons.title,
            type: TextFormatType.heading,
            tooltip: 'Heading',
          ),
          
          const Spacer(),
          
          // Format info
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingS,
              vertical: AppConstants.spacingXS,
            ),
            decoration: BoxDecoration(
              color: AppTheme.inkBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              activeFormats.isEmpty ? 'Normal' : _getActiveFormatText(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.inkBlue,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbarButton(
    BuildContext context, {
    required IconData icon,
    required TextFormatType type,
    required String tooltip,
  }) {
    final isActive = activeFormats.contains(type);
    
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onFormatSelected(type),
          borderRadius: BorderRadius.circular(AppConstants.radiusS),
          child: Container(
            padding: const EdgeInsets.all(AppConstants.spacingS),
            decoration: BoxDecoration(
              color: isActive 
                  ? AppTheme.tabBlue.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
              border: isActive
                  ? Border.all(
                      color: AppTheme.tabBlue,
                      width: 2,
                    )
                  : null,
            ),
            child: Icon(
              icon,
              size: 20,
              color: isActive ? AppTheme.tabBlue : AppTheme.inkBlue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 24,
      color: AppTheme.lineGray,
    );
  }

  String _getActiveFormatText() {
    final formats = activeFormats.map((format) {
      switch (format) {
        case TextFormatType.bold:
          return 'B';
        case TextFormatType.italic:
          return 'I';
        case TextFormatType.underline:
          return 'U';
        case TextFormatType.bulletList:
          return 'List';
        case TextFormatType.numberedList:
          return 'Num';
        case TextFormatType.heading:
          return 'H';
      }
    }).join(', ');
    
    return formats;
  }
}