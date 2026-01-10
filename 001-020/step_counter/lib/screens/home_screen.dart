import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/step_provider.dart';
import '../widgets/distance_display.dart';
import '../widgets/neumorphic_card.dart';
import '../config/theme_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StepProvider>().initialize();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.backgroundColor,
      body: SafeArea(
        child: Consumer<StepProvider>(
          builder: (context, stepProvider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Header
                  _buildHeader(context, stepProvider),
                  
                  const SizedBox(height: 40),
                  
                  // Main circular progress
                  CircularProgress(
                    progress: stepProvider.progress,
                    child: StepCounterDisplay(
                      steps: stepProvider.todaySteps,
                      goal: stepProvider.dailyGoal.targetSteps,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Stats cards
                  Row(
                    children: [
                      Expanded(
                        child: CalorieDisplay(
                          calories: stepProvider.calories,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DistanceDisplay(
                          distance: stepProvider.distance,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Control buttons (for Web/Windows)
                  if (!stepProvider.isMobilePlatform)
                    _buildSimulationControls(context, stepProvider),
                  
                  // Error message
                  if (stepProvider.errorMessage != null)
                    _buildErrorMessage(context, stepProvider),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildHeader(BuildContext context, StepProvider stepProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'StepCounter',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: ThemeConfig.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              stepProvider.isMobilePlatform ? 'Pedometer Active' : 'Simulation Mode',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ThemeConfig.textSecondary,
                  ),
            ),
          ],
        ),
        
        // Settings button
        NeumorphicCard(
          padding: const EdgeInsets.all(12),
          onTap: () => _showSettingsDialog(context, stepProvider),
          child: const Icon(
            Icons.settings,
            color: ThemeConfig.primaryColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildSimulationControls(BuildContext context, StepProvider stepProvider) {
    return Column(
      children: [
        // Start/Stop walking simulation
        NeumorphicCard(
          isPressed: stepProvider.isSimulating,
          onTap: () {
            if (stepProvider.isSimulating) {
              stepProvider.stopWalkingSimulation();
            } else {
              stepProvider.startWalkingSimulation();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                stepProvider.isSimulating ? Icons.pause : Icons.play_arrow,
                color: ThemeConfig.primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                stepProvider.isSimulating ? 'Stop Walking' : 'Start Walking',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ThemeConfig.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Manual add steps
        NeumorphicCard(
          onTap: () => stepProvider.addManualSteps(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: ThemeConfig.secondaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Add 10 Steps',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ThemeConfig.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildErrorMessage(BuildContext context, StepProvider stepProvider) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              stepProvider.errorMessage!,
              style: TextStyle(color: Colors.red.shade700),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showSettingsDialog(BuildContext context, StepProvider stepProvider) {
    final controller = TextEditingController(
      text: stepProvider.dailyGoal.targetSteps.toString(),
    );
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ThemeConfig.backgroundColor,
        title: const Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Daily Step Goal',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                stepProvider.resetDailyData();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Today\'s Steps'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newGoal = int.tryParse(controller.text) ?? 10000;
              stepProvider.updateDailyGoal(newGoal);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}