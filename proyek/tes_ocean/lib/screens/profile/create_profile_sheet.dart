import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/profile_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/primary_button.dart';

/// Form modal untuk membuat profil pengguna baru dengan validasi nama
/// sederhana sebelum disimpan ke local storage.
class CreateProfileSheet extends ConsumerStatefulWidget {
  const CreateProfileSheet({super.key});

  @override
  ConsumerState<CreateProfileSheet> createState() => _CreateProfileSheetState();
}

class _CreateProfileSheetState extends ConsumerState<CreateProfileSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      final profile = await ref
          .read(profileListProvider.notifier)
          .createProfile(_nameController.text);

      ref.read(activeProfileIdProvider.notifier).set(profile.id);

      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
                const Text(
                  'Buat Profil Baru',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Masukkan nama untuk profil tes kepribadian Anda.',
                  style: TextStyle(fontSize: 13.5, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: 'Contoh: Andi Pratama',
                    labelText: 'Nama',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    if (value.trim().length < 2) {
                      return 'Nama minimal 2 karakter';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: 'Simpan & Lanjutkan',
                  icon: Icons.arrow_forward_rounded,
                  isLoading: _isSubmitting,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
