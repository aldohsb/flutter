import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notepad_pro/providers/note_provider.dart';
import 'package:notepad_pro/providers/tag_provider.dart';
import 'package:notepad_pro/models/note_model.dart';
import 'package:notepad_pro/widgets/rich_text_toolbar.dart';
import 'package:notepad_pro/widgets/tag_chip.dart';
import 'package:notepad_pro/utils/constants.dart';
import 'package:notepad_pro/theme/app_theme.dart';

class NoteEditorScreen extends StatefulWidget {
  final String noteId;

  const NoteEditorScreen({
    super.key,
    required this.noteId,
  });

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final Set<TextFormatType> _activeFormats = {};
  
  NoteModel? _note;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  void _loadNote() {
    final noteProvider = context.read<NoteProvider>();
    final hiveService = noteProvider;
    
    setState(() {
      _note = context.read<NoteProvider>().notes.firstWhere(
        (n) => n.id == widget.noteId,
      );
      _titleController.text = _note!.title;
      _contentController.text = _note!.content;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _saveNote();
    _titleController.dispose();
    _contentController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (_note == null) return;
    
    final updatedNote = _note!.copyWith(
      title: _titleController.text.isEmpty ? 'Untitled' : _titleController.text,
      content: _contentController.text,
    );
    
    await context.read<NoteProvider>().updateNote(updatedNote);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _saveNote();
            Navigator.pop(context);
          },
        ),
        title: const Text('Edit Note'),
        actions: [
          // Favorite toggle
          IconButton(
            icon: Icon(
              _note!.isFavorite ? Icons.star : Icons.star_outline,
              color: _note!.isFavorite ? AppTheme.tabRed : null,
            ),
            onPressed: () {
              context.read<NoteProvider>().toggleFavorite(widget.noteId);
              setState(() {
                _note = context.read<NoteProvider>().notes.firstWhere(
                  (n) => n.id == widget.noteId,
                );
              });
            },
          ),
          
          // More options
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline),
                    SizedBox(width: 8),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'delete') {
                _deleteNote();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Title field
          _buildTitleField(),
          
          const Divider(height: 1),
          
          // Tags section
          _buildTagsSection(),
          
          const Divider(height: 1),
          
          // Content field
          Expanded(
            child: _buildContentField(),
          ),
          
          // Rich text toolbar
          RichTextToolbar(
            onFormatSelected: _applyFormat,
            activeFormats: _activeFormats,
          ),
        ],
      ),
    );
  }

  Widget _buildTitleField() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.paperWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _titleController,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        decoration: const InputDecoration(
          hintText: 'Title',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        maxLines: 1,
      ),
    );
  }

  Widget _buildTagsSection() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.paperYellow.withOpacity(0.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _tagController,
                  decoration: const InputDecoration(
                    hintText: 'Add tag...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  onSubmitted: _addTag,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _addTag(_tagController.text),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          
          if (_note!.tags.isNotEmpty) ...[
            const SizedBox(height: AppConstants.spacingS),
            Wrap(
              spacing: AppConstants.spacingS,
              runSpacing: AppConstants.spacingS,
              children: _note!.tags.map((tag) {
                return TagChip(
                  label: tag,
                  onDeleted: () => _removeTag(tag),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContentField() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: const BoxDecoration(
        color: AppTheme.paperWhite,
        // Paper lines effect
        image: DecorationImage(
          image: NetworkImage(
            'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIzMiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48bGluZSB4MT0iMCIgeTE9IjMxIiB4Mj0iMTAwJSIgeTI9IjMxIiBzdHJva2U9IiNFMEUwRTAiIHN0cm9rZS13aWR0aD0iMSIvPjwvc3ZnPg==',
          ),
          repeat: ImageRepeat.repeatY,
          opacity: 0.3,
        ),
      ),
      child: TextField(
        controller: _contentController,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          height: 2.0,
        ),
        decoration: const InputDecoration(
          hintText: 'Start writing...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
      ),
    );
  }

  void _applyFormat(TextFormatType type) {
    final selection = _contentController.selection;
    if (!selection.isValid) return;

    final text = _contentController.text;
    final selectedText = text.substring(
      selection.start,
      selection.end,
    );

    String newText;
    int cursorOffset = 0;

    switch (type) {
      case TextFormatType.bold:
        newText = '**$selectedText**';
        cursorOffset = 2;
        break;
      case TextFormatType.italic:
        newText = '*$selectedText*';
        cursorOffset = 1;
        break;
      case TextFormatType.underline:
        newText = '_${selectedText}_';
        cursorOffset = 1;
        break;
      case TextFormatType.bulletList:
        newText = '• $selectedText';
        cursorOffset = 2;
        break;
      case TextFormatType.numberedList:
        newText = '1. $selectedText';
        cursorOffset = 3;
        break;
      case TextFormatType.heading:
        newText = '# $selectedText';
        cursorOffset = 2;
        break;
    }

    final before = text.substring(0, selection.start);
    final after = text.substring(selection.end);
    
    _contentController.value = TextEditingValue(
      text: before + newText + after,
      selection: TextSelection.collapsed(
        offset: selection.start + newText.length,
      ),
    );

    setState(() {
      if (_activeFormats.contains(type)) {
        _activeFormats.remove(type);
      } else {
        _activeFormats.add(type);
      }
    });
  }

  void _addTag(String tagName) {
    if (tagName.trim().isEmpty) return;
    
    final cleanTag = tagName.trim().toLowerCase();
    
    // Add to note
    context.read<NoteProvider>().addTagToNote(widget.noteId, cleanTag);
    
    // Create or update tag in tag provider
    context.read<TagProvider>().getOrCreateTag(cleanTag);
    context.read<TagProvider>().incrementTagUsage(cleanTag);
    
    // Update local note
    setState(() {
      _note = context.read<NoteProvider>().notes.firstWhere(
        (n) => n.id == widget.noteId,
      );
    });
    
    _tagController.clear();
  }

  void _removeTag(String tagName) {
    context.read<NoteProvider>().removeTagFromNote(widget.noteId, tagName);
    context.read<TagProvider>().decrementTagUsage(tagName);
    
    setState(() {
      _note = context.read<NoteProvider>().notes.firstWhere(
        (n) => n.id == widget.noteId,
      );
    });
  }

  void _deleteNote() {
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
              context.read<NoteProvider>().deleteNote(widget.noteId);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close editor
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}