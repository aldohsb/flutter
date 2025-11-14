import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notepad_pro/providers/folder_provider.dart';
import 'package:notepad_pro/widgets/folder_item.dart';
import 'package:notepad_pro/utils/constants.dart';
import 'package:notepad_pro/theme/app_theme.dart';

class FolderScreen extends StatelessWidget {
  const FolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Folders'),
      ),
      body: Consumer<FolderProvider>(
        builder: (context, folderProvider, child) {
          final folders = folderProvider.folders;
          
          if (folders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_outlined,
                    size: 80,
                    color: AppTheme.inkBlue.withOpacity(0.3),
                  ),
                  const SizedBox(height: AppConstants.spacingM),
                  Text(
                    'No folders yet',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.inkBlue.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.spacingM,
            ),
            itemCount: folders.length,
            itemBuilder: (context, index) {
              final folder = folders[index];
              
              return FolderItem(
                folder: folder,
                isSelected: false,
                onTap: () {
                  // Navigate back with selected folder
                  Navigator.pop(context, folder.id);
                },
                onLongPress: folder.id != AppConstants.defaultFolderId
                    ? () => _showFolderOptions(context, folder.id)
                    : null,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateFolderDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('New Folder'),
      ),
    );
  }

  void _showCreateFolderDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Folder'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Folder name',
          ),
          autofocus: true,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              context.read<FolderProvider>().createFolder(
                name: value,
              );
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<FolderProvider>().createFolder(
                  name: controller.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showFolderOptions(BuildContext context, String folderId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Rename'),
              onTap: () {
                Navigator.pop(context);
                _showRenameFolderDialog(context, folderId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: const Text('Change Color'),
              onTap: () {
                Navigator.pop(context);
                _showColorPicker(context, folderId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context, folderId);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showRenameFolderDialog(BuildContext context, String folderId) {
    final folder = context.read<FolderProvider>().getFolderById(folderId);
    if (folder == null) return;
    
    final TextEditingController controller = TextEditingController(
      text: folder.name,
    );
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Folder'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Folder name',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<FolderProvider>().renameFolder(
                  folderId,
                  controller.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Rename'),
          ),
        ],
      ),
    );
  }

  void _showColorPicker(BuildContext context, String folderId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Color'),
        content: Wrap(
          spacing: AppConstants.spacingS,
          runSpacing: AppConstants.spacingS,
          children: AppConstants.tagColors.map((color) {
            return GestureDetector(
              onTap: () {
                context.read<FolderProvider>().changeFolderColor(
                  folderId,
                  color,
                );
                Navigator.pop(context);
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String folderId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Folder'),
        content: const Text(
          'Are you sure? All notes will be moved to the default folder.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<FolderProvider>().deleteFolder(folderId);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}