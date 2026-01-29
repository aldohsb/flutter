import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';
import '../services/audio_service.dart';
import 'home_screen.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({super.key});

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  final TextEditingController _nameController = TextEditingController();
  List<UserModel> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final users = await StorageService.instance.getAllUsers();
    setState(() {
      _users = users;
      _isLoading = false;
    });
  }

  Future<void> _createNewUser() async {
    final name = _nameController.text.trim();
    
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama tidak boleh kosong'),
          backgroundColor: AppTheme.wrongRed,
        ),
      );
      return;
    }

    final newUser = UserModel(
      id: const Uuid().v4(),
      username: name,
      createdAt: DateTime.now(),
      lastActive: DateTime.now(),
    );

    await StorageService.instance.saveCurrentUser(newUser);
    await AudioService.instance.playSuccessSound();

    if (!mounted) return;
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomeScreen(user: newUser)),
    );
  }

  Future<void> _selectUser(UserModel user) async {
    await StorageService.instance.saveCurrentUser(user);
    await StorageService.instance.updateUserLastActive(user.id);
    await AudioService.instance.playClickSound();

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomeScreen(user: user)),
    );
  }

  Future<void> _deleteUser(UserModel user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Pengguna'),
        content: Text('Yakin ingin menghapus "${user.username}"?\nSemua progress akan hilang.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppTheme.wrongRed),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await StorageService.instance.deleteUser(user.id);
      await _loadUsers();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.gardenDecoration,
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      
                      // Welcome Title
                      Text(
                        'مَرْحَبًا',
                        style: AppTheme.arabicTextStyle.copyWith(
                          fontSize: 48,
                          color: AppTheme.primaryGreen,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        'Selamat Datang di LisaanaQuiz',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        'Pilih atau buat pengguna baru',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textLight,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // New User Input
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: AppTheme.arabianCardDecoration,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Buat Pengguna Baru',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            
                            const SizedBox(height: 16),
                            
                            TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Nama',
                                hintText: 'Masukkan nama Anda',
                                prefixIcon: Icon(Icons.person),
                              ),
                              textCapitalization: TextCapitalization.words,
                              onSubmitted: (_) => _createNewUser(),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            ElevatedButton.icon(
                              onPressed: _createNewUser,
                              icon: const Icon(Icons.add),
                              label: const Text('Mulai Belajar'),
                            ),
                          ],
                        ),
                      ),
                      
                      if (_users.isNotEmpty) ...[
                        const SizedBox(height: 32),
                        
                        Text(
                          'Atau Pilih Pengguna',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // User List
                        ..._users.map((user) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _UserCard(
                            user: user,
                            onTap: () => _selectUser(user),
                            onDelete: () => _deleteUser(user),
                          ),
                        )),
                      ],
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _UserCard({
    required this.user,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final lastActive = _formatDate(user.lastActive);
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.lightGreen.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: AppTheme.cardShadow,
          ),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppTheme.primaryGradient,
                ),
                child: Center(
                  child: Text(
                    user.username[0].toUpperCase(),
                    style: const TextStyle(
                      color: AppTheme.textWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Terakhir aktif: $lastActive',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Delete Button
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline),
                color: AppTheme.wrongRed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return 'Baru saja';
      }
      return '${difference.inHours} jam lalu';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}