import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';
import '../../data/models/category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddCategoryDialog(context),
          ),
        ],
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, _) {
          final categories = provider.categories;
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = provider.selectedCategory?.id == category.id;
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                color: isSelected
                    ? category.color.withValues(alpha: 0.1)
                    : null,
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: category.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      category.icon,
                      color: category.color,
                    ),
                  ),
                  title: Text(
                    category.name,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: category.color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Active',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 20),
                        onPressed: () => _showEditCategoryDialog(context, category),
                      ),
                      if (categories.length > 1)
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 20),
                          color: Colors.red,
                          onPressed: () => _confirmDelete(context, category),
                        ),
                    ],
                  ),
                  onTap: () {
                    provider.selectCategory(category);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
  
  void _showAddCategoryDialog(BuildContext context) {
    final nameController = TextEditingController();
    Color selectedColor = Colors.blue;
    IconData selectedIcon = Icons.category_outlined;
    
    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              _buildColorPicker(selectedColor, (color) {
                setState(() => selectedColor = color);
              }),
              const SizedBox(height: 16),
              _buildIconPicker(selectedIcon, (icon) {
                setState(() => selectedIcon = icon);
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  final category = Category(
                    name: nameController.text,
                    color: selectedColor,
                    icon: selectedIcon,
                  );
                  
                  dialogContext.read<CategoryProvider>().addCategory(category);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showEditCategoryDialog(BuildContext context, Category category) {
    final nameController = TextEditingController(text: category.name);
    Color selectedColor = category.color;
    IconData selectedIcon = category.icon;
    
    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              _buildColorPicker(selectedColor, (color) {
                setState(() => selectedColor = color);
              }),
              const SizedBox(height: 16),
              _buildIconPicker(selectedIcon, (icon) {
                setState(() => selectedIcon = icon);
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updated = category.copyWith(
                  name: nameController.text,
                  color: selectedColor,
                  icon: selectedIcon,
                );
                
                dialogContext.read<CategoryProvider>().updateCategory(updated);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildColorPicker(Color selected, Function(Color) onChanged) {
    final colors = [
      Colors.blue, Colors.red, Colors.green, Colors.orange,
      Colors.purple, Colors.teal, Colors.pink, Colors.amber,
    ];
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colors.map((color) {
        return GestureDetector(
          onTap: () => onChanged(color),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: selected == color
                  ? Border.all(color: Colors.white, width: 3)
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildIconPicker(IconData selected, Function(IconData) onChanged) {
    final icons = [
      Icons.work_outline, Icons.school_outlined, Icons.coffee_outlined,
      Icons.sports_esports_outlined, Icons.book_outlined, Icons.fitness_center_outlined,
      Icons.restaurant_outlined, Icons.music_note_outlined,
    ];
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: icons.map((icon) {
        return GestureDetector(
          onTap: () => onChanged(icon),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: selected == icon ? Colors.blue : Colors.grey,
                width: selected == icon ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon),
          ),
        );
      }).toList(),
    );
  }
  
  void _confirmDelete(BuildContext context, Category category) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Category'),
        content: Text('Are you sure you want to delete "${category.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              dialogContext.read<CategoryProvider>().deleteCategory(category.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
