import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class MacroCalculatorScreen extends StatefulWidget {
  const MacroCalculatorScreen({super.key});

  @override
  State<MacroCalculatorScreen> createState() => _MacroCalculatorScreenState();
}

class _MacroCalculatorScreenState extends State<MacroCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _caloriesController = TextEditingController();
  
  double _activityLevel = 1.2;
  Map<String, double>? _calculatedMacros;
  double? _tdee;

  @override
  void initState() {
    super.initState();
    _calculateFromUser();
  }

  void _calculateFromUser() {
    final user = context.read<UserProvider>().user;
    if (user != null) {
      final age = DateTime.now().year - user.startDate.year;
      final bmr = Helpers.calculateBMR(
        user.gender,
        user.currentWeight,
        user.height,
        age > 18 ? age : 25, // Default age if not accurate
      );
      _tdee = Helpers.calculateTDEE(bmr, _activityLevel);
      _caloriesController.text = _tdee!.toStringAsFixed(0);
      _calculate();
    }
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final calories = double.parse(_caloriesController.text);
    setState(() {
      _calculatedMacros = Helpers.calculateMacros(calories);
    });
  }

  @override
  void dispose() {
    _caloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Makro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Card
              Card(
                color: AppConstants.accentYellow.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppConstants.accentYellow,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Kalkulator ini menghitung kebutuhan makro untuk diet keto berdasarkan kalori harian Anda.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Activity Level
              Text(
                'Tingkat Aktivitas',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Card(
                child: Column(
                  children: [
                    RadioListTile<double>(
                      title: const Text('Sedentary'),
                      subtitle: const Text('Sedikit atau tidak ada olahraga'),
                      value: 1.2,
                      groupValue: _activityLevel,
                      onChanged: (value) {
                        setState(() {
                          _activityLevel = value!;
                          _calculateFromUser();
                        });
                      },
                    ),
                    RadioListTile<double>(
                      title: const Text('Ringan'),
                      subtitle: const Text('Olahraga 1-3 hari/minggu'),
                      value: 1.375,
                      groupValue: _activityLevel,
                      onChanged: (value) {
                        setState(() {
                          _activityLevel = value!;
                          _calculateFromUser();
                        });
                      },
                    ),
                    RadioListTile<double>(
                      title: const Text('Moderat'),
                      subtitle: const Text('Olahraga 3-5 hari/minggu'),
                      value: 1.55,
                      groupValue: _activityLevel,
                      onChanged: (value) {
                        setState(() {
                          _activityLevel = value!;
                          _calculateFromUser();
                        });
                      },
                    ),
                    RadioListTile<double>(
                      title: const Text('Aktif'),
                      subtitle: const Text('Olahraga 6-7 hari/minggu'),
                      value: 1.725,
                      groupValue: _activityLevel,
                      onChanged: (value) {
                        setState(() {
                          _activityLevel = value!;
                          _calculateFromUser();
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Calories Input
              CustomTextField(
                label: 'Target Kalori per Hari',
                hint: '2000',
                controller: _caloriesController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.local_fire_department,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kalori tidak boleh kosong';
                  }
                  final cal = double.tryParse(value);
                  if (cal == null || cal < 1000 || cal > 5000) {
                    return 'Kalori harus antara 1000-5000';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              if (_tdee != null)
                Text(
                  'Estimasi TDEE Anda: ${_tdee!.toStringAsFixed(0)} kkal',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),

              const SizedBox(height: 24),

              // Calculate Button
              CustomButton(
                text: 'Hitung Makro',
                onPressed: _calculate,
                icon: Icons.calculate,
                width: double.infinity,
              ),

              const SizedBox(height: 24),

              // Results
              if (_calculatedMacros != null) ...[
                Text(
                  'Hasil Perhitungan',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),

                // Keto Ratio Info
                Card(
                  color: AppConstants.primaryRed.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    child: Column(
                      children: [
                        Text(
                          'Rasio Keto Standar',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildRatioItem('70%', 'Lemak', Colors.green),
                            _buildRatioItem('25%', 'Protein', Colors.blue),
                            _buildRatioItem('5%', 'Karbo', Colors.orange),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Macro Cards
                _buildMacroCard(
                  'Lemak',
                  _calculatedMacros!['fat']!,
                  Icons.water_drop,
                  Colors.green,
                  '9 kkal/gram',
                ),
                const SizedBox(height: 12),
                _buildMacroCard(
                  'Protein',
                  _calculatedMacros!['protein']!,
                  Icons.fitness_center,
                  Colors.blue,
                  '4 kkal/gram',
                ),
                const SizedBox(height: 12),
                _buildMacroCard(
                  'Karbohidrat',
                  _calculatedMacros!['carbs']!,
                  Icons.grain,
                  Colors.orange,
                  '4 kkal/gram',
                ),

                const SizedBox(height: 24),

                // Tips
                Card(
                  color: AppConstants.accentYellow.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.lightbulb,
                              color: AppConstants.accentYellow,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Tips',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '• Prioritaskan lemak sehat: minyak kelapa, alpukat, mentega\n'
                          '• Protein dari sumber berkualitas: daging, ikan, telur\n'
                          '• Batasi karbo di bawah 20-50g untuk ketosis optimal\n'
                          '• Track makanan dengan food diary\n'
                          '• Jangan lupa elektrolit: garam, kalium, magnesium',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatioItem(String percentage, String label, Color color) {
    return Column(
      children: [
        Text(
          percentage,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildMacroCard(
    String label,
    double grams,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${grams.toStringAsFixed(0)}g',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  'per hari',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}