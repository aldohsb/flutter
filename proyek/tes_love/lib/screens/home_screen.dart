import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/user_avatar.dart';
import 'quiz_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            return CustomScrollView(
              slivers: [
                // ── Header ────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.favorite_rounded,
                              color: AppColors.primary,
                              size: 28,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Tes Love Language',
                              style: AppTextStyles.headingMedium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Siapa yang akan\ntes hari ini?',
                          style: AppTextStyles.display,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '30 pertanyaan · ±5 menit · Hasil langsung',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0, duration: 500.ms),
                  ),
                ),

                // ── Daftar User ───────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final user = userProvider.users[index];
                        return _UserCard(user: user, index: index);
                      },
                      childCount: userProvider.users.length,
                    ),
                  ),
                ),

                // ── Tambah User ───────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                    child: _AddUserButton(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final UserModel user;
  final int index;

  const _UserCard({required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _onSelectUser(context, user),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                UserAvatar(name: user.name, size: 48),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: AppTextStyles.headingMedium.copyWith(fontSize: 16)),
                      const SizedBox(height: 2),
                      Text(
                        'Bergabung ${_formatDate(user.createdAt)}',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                // Riwayat
                IconButton(
                  onPressed: () => _openHistory(context, user),
                  icon: const Icon(Icons.history_rounded, size: 20),
                  color: AppColors.textSecondary,
                  tooltip: 'Riwayat quiz',
                ),
                // Mulai quiz
                FilledButton.icon(
                  onPressed: () => _onSelectUser(context, user),
                  icon: const Icon(Icons.play_arrow_rounded, size: 18),
                  label: const Text('Mulai'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    textStyle: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate(key: ValueKey('user_$index'))
        .fadeIn(duration: 400.ms, delay: (index * 60).ms)
        .slideY(begin: 0.08, end: 0, duration: 400.ms, delay: (index * 60).ms);
  }

  void _onSelectUser(BuildContext context, UserModel user) {
    context.read<UserProvider>().setActiveUser(user);
    context.read<QuizProvider>().resetQuiz();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  void _openHistory(BuildContext context, UserModel user) {
    context.read<UserProvider>().setActiveUser(user);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const HistoryScreen()),
    );
  }

  String _formatDate(DateTime dt) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];
    return '${dt.day} ${months[dt.month]} ${dt.year}';
  }
}

class _AddUserButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _showAddUserDialog(context),
      icon: const Icon(Icons.person_add_rounded, size: 20),
      label: const Text('Tambah Pengguna Baru'),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(double.infinity, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 300.ms);
  }

  void _showAddUserDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Pengguna Baru', style: AppTextStyles.headingMedium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Masukkan nama untuk membuat profil baru.',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              style: AppTextStyles.bodyLarge,
              decoration: const InputDecoration(
                hintText: 'Nama kamu...',
                prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.primary),
              ),
              onSubmitted: (_) => _submit(ctx, controller.text),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: AppTextStyles.bodyMedium),
          ),
          FilledButton(
            onPressed: () => _submit(ctx, controller.text),
            style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Buat Profil'),
          ),
        ],
      ),
    );
  }

  void _submit(BuildContext ctx, String name) {
    if (name.trim().isEmpty) return;
    ctx.read<UserProvider>().addUser(name);
    Navigator.pop(ctx);
  }
}