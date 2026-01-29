import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../providers/app_providers.dart';
import '../home/home_screen.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({super.key});

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  late TextEditingController _usernameController;
  bool _isCreatingUser = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _createNewUser() {
    final username = _usernameController.text.trim();
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a username')),
      );
      return;
    }

    setState(() => _isCreatingUser = true);

    context.read<UserProvider>().createUser(username).then((_) {
      _usernameController.clear();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating user: $e')),
      );
      setState(() => _isCreatingUser = false);
    });
  }

  void _selectUser(String username) {
    context.read<UserProvider>().switchUser(username).then((_) {
      context.read<ProgressProvider>().loadProgress(username);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  void _deleteUser(String username) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete $username?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<UserProvider>().deleteUser(username);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              const SizedBox(height: AppSpacing.xxxl),
              Text(
                'UsamaQuiz',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Learn Japanese - Hiragana, Katakana & Kanji',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Existing Users
              Consumer<UserProvider>(
                builder: (context, userProvider, _) {
                  if (userProvider.allUsers.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select User',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        ...userProvider.allUsers.map((user) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.md),
                            child: _buildUserCard(
                              username: user.username,
                              level: user.currentLevel,
                              stars: user.totalStars,
                            ),
                          );
                        }),
                        const SizedBox(height: AppSpacing.xxxl),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),

              // Create New User
              Text(
                'Create New User',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter username',
                  enabled: !_isCreatingUser,
                ),
                onSubmitted: (_) => _createNewUser(),
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _isCreatingUser ? null : _createNewUser,
                child: _isCreatingUser
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : const Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard({
    required String username,
    required int level,
    required int stars,
  }) {
    return Card(
      child: InkWell(
        onTap: () => _selectUser(username),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(Icons.trending_up, size: 16, color: AppColors.textMid),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'Level $level',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        ...List.generate(
                          (stars / 3).ceil(),
                          (index) => const Padding(
                            padding: EdgeInsets.only(right: AppSpacing.xs),
                            child: Icon(
                              Icons.star,
                              size: 14,
                              color: AppColors.accentGold,
                            ),
                          ),
                        ),
                        Text(
                          '$stars',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _deleteUser(username),
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}