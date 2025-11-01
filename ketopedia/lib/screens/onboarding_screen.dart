import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../models/weight_entry_model.dart';
import '../providers/user_provider.dart';
import '../providers/food_provider.dart';
import '../providers/weight_provider.dart';
import '../providers/notification_provider.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetController = TextEditingController();

  Gender _selectedGender = Gender.pria;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = UserModel(
        name: _nameController.text.trim(),
        gender: _selectedGender,
        age: int.parse(_ageController.text),
        height: double.parse(_heightController.text),
        currentWeight: double.parse(_weightController.text),
        targetWeight: double.parse(_targetController.text),
        startDate: DateTime.now(),
      );

      final userProvider = context.read<UserProvider>();
      final success = await userProvider.createUser(user);

      if (success && mounted) {
        // Load foods and initialize notifications
        final foodProvider = context.read<FoodProvider>();
        await foodProvider.loadFoods();
        
        // Create initial weight entry
        if (userProvider.user != null) {
          final weightProvider = context.read<WeightProvider>();
          final initialWeightEntry = WeightEntryModel(
            userId: userProvider.user!.id!,
            weight: double.parse(_weightController.text),
            date: DateTime.now(),
            notes: 'Berat awal saat memulai diet keto',
          );
          await weightProvider.addEntry(initialWeightEntry);
          
          // Initialize notifications
          final notificationProvider = context.read<NotificationProvider>();
          await notificationProvider.initialize(userProvider.user!.id!);
        }

        if (mounted) {
          Helpers.showSnackBar(
            context,
            'Selamat datang, ${user.name}! Mari mulai journey keto! 🔥',
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        setState(() => _isLoading = false);
        if (mounted) {
          final errorMsg = userProvider.error ?? 'Gagal membuat profil. Silakan coba lagi.';
          Helpers.showSnackBar(
            context,
            errorMsg,
            isError: true,
          );
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        Helpers.showSnackBar(
          context,
          'Error: ${e.toString()}',
          isError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // Header
                const Icon(
                  Icons.restaurant_menu,
                  size: 80,
                  color: AppConstants.primaryRed,
                ),
                const SizedBox(height: 16),
                Text(
                  'Selamat Datang!',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppConstants.primaryRed,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Mari setup profil Anda untuk\nmemulai journey diet keto',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Name Field
                CustomTextField(
                  label: 'Nama',
                  hint: 'Masukkan nama Anda',
                  controller: _nameController,
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Gender Selection
                Text(
                  'Jenis Kelamin',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildGenderCard(
                        gender: Gender.pria,
                        icon: Icons.male,
                        label: 'Pria',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildGenderCard(
                        gender: Gender.wanita,
                        icon: Icons.female,
                        label: 'Wanita',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Age Field
                CustomTextField(
                  label: 'Umur (tahun)',
                  hint: '25',
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.cake,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Umur tidak boleh kosong';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 15 || age > 100) {
                      return 'Umur harus antara 15-100 tahun';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Height Field
                CustomTextField(
                  label: 'Tinggi Badan (cm)',
                  hint: '170',
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.height,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tinggi badan tidak boleh kosong';
                    }
                    final height = double.tryParse(value);
                    if (height == null || height < 100 || height > 250) {
                      return 'Tinggi badan harus antara 100-250 cm';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Weight Field
                CustomTextField(
                  label: 'Berat Badan Saat Ini (kg)',
                  hint: '70',
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  prefixIcon: Icons.monitor_weight,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Berat badan tidak boleh kosong';
                    }
                    final weight = double.tryParse(value);
                    if (weight == null || weight < 30 || weight > 300) {
                      return 'Berat badan harus antara 30-300 kg';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Target Weight Field
                CustomTextField(
                  label: 'Target Berat Badan (kg)',
                  hint: '65',
                  controller: _targetController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  prefixIcon: Icons.flag,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Target berat tidak boleh kosong';
                    }
                    final target = double.tryParse(value);
                    if (target == null || target < 30 || target > 300) {
                      return 'Target berat harus antara 30-300 kg';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                // Submit Button
                CustomButton(
                  text: 'Mulai Journey Keto',
                  onPressed: _submit,
                  isLoading: _isLoading,
                  icon: Icons.rocket_launch,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderCard({
    required Gender gender,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = gender),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppConstants.primaryRed.withOpacity(0.1)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(
            color: isSelected
                ? AppConstants.primaryRed
                : Theme.of(context).dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected
                  ? AppConstants.primaryRed
                  : Theme.of(context).iconTheme.color,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected ? AppConstants.primaryRed : null,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}