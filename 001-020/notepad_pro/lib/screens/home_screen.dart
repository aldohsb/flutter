import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notepad_pro/providers/note_provider.dart';
import 'package:notepad_pro/providers/folder_provider.dart';
import 'package:notepad_pro/providers/tag_provider.dart';
import 'package:notepad_pro/screens/note_editor_screen.dart';
import 'package:notepad_pro/screens/folder_screen.dart';
import 'package:notepad_pro/widgets/note_card.dart';
import 'package:notepad_pro/widgets/folder_item.dart';
import 'package:notepad_pro/widgets/tag_chip.dart';
import 'package:notepad_pro/utils/constants.dart';
import 'package:notepad_pro/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showFolders = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          // Toggle favorites
          Consumer<NoteProvider>(
            builder: (context, noteProvider, child) {
              return IconButton(
                icon: Icon(
                  noteProvider.showFavoritesOnly 
                      ? Icons.star 
                      : Icons.star_outline,
                  color: noteProvider.showFavoritesOnly 
                      ? AppTheme.tabRed 
                      : null,
                ),
                onPressed: () {
                  noteProvider.toggleFavoritesFilter();
                },
                tooltip: 'Favorites',
              );
            },
          ),
          
          // Toggle folder sidebar
          IconButton(
            icon: Icon(_showFolders ? Icons.menu_open : Icons.menu),
            onPressed: () {
              setState(() {
                _showFolders = !_showFolders;
              });
            },
            tooltip: 'Folders',
          ),
        ],
      ),
      body: Row(
        children: [
          // Folder Sidebar
          if (_showFolders)
            Container(
              width: 280,
              decoration: BoxDecoration(
                color: AppTheme.paperYellow.withOpacity(0.3),
                border: Border(
                  right: BorderSide(
                    color: AppTheme.lineGray,
                    width: 1,
                  ),
                ),
              ),
              child: _buildFolderSidebar(),
            ),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Search Bar
                _buildSearchBar(),
                
                // Popular Tags
                _buildPopularTags(),
                
                // Notes List
                Expanded(
                  child: _buildNotesList(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createNewNote(context),
        icon: const Icon(Icons.add),
        label: const Text('New Note'),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search notes...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<NoteProvider>().clearSearch();
                  },
                )
              : null,
        ),
        onChanged: (value) {
          context.read<NoteProvider>().setSearchQuery(value);
        },
      ),
    );
  }

  Widget _buildPopularTags() {
    return Consumer<TagProvider>(
      builder: (context, tagProvider, child) {
        final popularTags = tagProvider.getPopularTags(limit: 5);
        
        if (popularTags.isEmpty) return const SizedBox.shrink();
        
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingM,
            vertical: AppConstants.spacingS,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular Tags',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppConstants.spacingS),
              Wrap(
                spacing: AppConstants.spacingS,
                runSpacing: AppConstants.spacingS,
                children: popularTags.map((tag) {
                  return TagChip(
                    label: tag.name,
                    color: tag.color,
                    onTap: () {
                      // Filter by tag
                      _searchController.text = tag.name;
                      context.read<NoteProvider>().setSearchQuery(tag.name);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotesList() {
    return Consumer<NoteProvider>(
      builder: (context, noteProvider, child) {
        final notes = noteProvider.notes;
        
        if (notes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.note_outlined,
                  size: 80,
                  color: AppTheme.inkBlue.withOpacity(0.3),
                ),
                const SizedBox(height: AppConstants.spacingM),
                Text(
                  'No notes yet',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.inkBlue.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingS),
                Text(
                  'Tap the + button to create your first note',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.inkBlue.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return NoteCard(
              note: note,
              onTap: () => _openNoteEditor(context, note.id),
              onFavoriteToggle: () {
                noteProvider.toggleFavorite(note.id);
              },
              onDelete: () => _deleteNote(context, note.id),
            );
          },
        );
      },
    );
  }

  Widget _buildFolderSidebar() {
    return Column(
      children: [
        // Folder header
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingM),
          child: Row(
            children: [
              Text(
                'Folders',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showCreateFolderDialog(context),
                tooltip: 'New Folder',
              ),
            ],
          ),
        ),
        
        const Divider(height: 1),
        
        // Folders list
        Expanded(
          child: Consumer2<FolderProvider, NoteProvider>(
            builder: (context, folderProvider, noteProvider, child) {
              final folders = folderProvider.folders;
              
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.spacingS,
                ),
                itemCount: folders.length,
                itemBuilder: (context, index) {
                  final folder = folders[index];
                  final isSelected = noteProvider.selectedFolderId == folder.id;
                  
                  return FolderItem(
                    folder: folder,
                    isSelected: isSelected,
                    onTap: () {
                      if (isSelected) {
                        noteProvider.setSelectedFolder(null);
                      } else {
                        noteProvider.setSelectedFolder(folder.id);
                      }
                    },
                    onLongPress: () {
                      if (folder.id != AppConstants.defaultFolderId) {
                        _showFolderOptions(context, folder.id);
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _createNewNote(BuildContext context) async {
    final noteProvider = context.read<NoteProvider>();
    final folderProvider = context.read<FolderProvider>();
    
    final selectedFolder = noteProvider.selectedFolderId ?? 
        folderProvider.defaultFolder?.id ?? 
        AppConstants.defaultFolderId;
    
    final note = await noteProvider.createNote(
      title: 'Untitled',
      folderId: selectedFolder,
    );
    
    if (context.mounted) {
      _openNoteEditor(context, note.id);
    }
  }

  void _openNoteEditor(BuildContext context, String noteId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(noteId: noteId),
      ),
    );
  }

  void _deleteNote(BuildContext context, String noteId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<NoteProvider>().deleteNote(noteId);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
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
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Rename'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement rename
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              Navigator.pop(context);
              context.read<FolderProvider>().deleteFolder(folderId);
            },
          ),
        ],
      ),
    );
  }
}