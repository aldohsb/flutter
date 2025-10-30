// Widget untuk menampilkan tracker air (visual bottle dengan animasi)

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/water_provider.dart';
import '../utils/constants.dart';

class WaterTrackerWidget extends StatefulWidget {
  const WaterTrackerWidget({super.key});

  @override
  State<WaterTrackerWidget> createState() => _WaterTrackerWidgetState();
}

class _WaterTrackerWidgetState extends State<WaterTrackerWidget>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _splashController;
  late Animation<double> _splashAnimation;
  bool _showSplash = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    
    // Wave animation controller - continuous loop
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    
    // Start wave animation
    _waveController.repeat();
    
    // Splash animation controller
    _splashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    // Splash scale animation
    _splashAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _splashController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _isDisposed = true;
    _waveController.dispose();
    _splashController.dispose();
    super.dispose();
  }

  // Trigger splash animation
  void _triggerSplash() {
    if (_isDisposed || !mounted) return;
    
    setState(() {
      _showSplash = true;
    });
    
    _splashController.forward(from: 0.0).then((_) {
      if (_isDisposed || !mounted) return;
      
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_isDisposed || !mounted) return;
        
        setState(() {
          _showSplash = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterProvider>(
      builder: (context, provider, child) {
        final percentage = provider.todayProgressPercentage / 100;
        
        return Container(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppConstants.primaryColor.withValues(alpha: 0.15),
                AppConstants.backgroundColor.withValues(alpha: 0.5),
                Colors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(
              AppConstants.borderRadiusLarge,
            ),
          ),
          child: Column(
            children: [
              // === GREETING TEXT ===
              Row(
                children: [
                  const Text('👋', style: TextStyle(fontSize: 28)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello ${provider.userName}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          'Stay hydrated today!',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.paddingLarge),
              
              // === WATER BOTTLE VISUAL WITH WAVE ===
              SizedBox(
                height: 320,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Bottle Container dengan gradient
                    _buildBottleContainer(context, percentage),
                    
                    // Center stats
                    _buildCenterStats(context, provider, percentage),
                    
                    // Splash effect
                    if (_showSplash)
                      _buildSplashEffect(),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.paddingLarge),
              
              // === QUICK ADD BUTTONS ===
              _buildQuickAddButtons(context, provider),
            ],
          ),
        );
      },
    );
  }

  // Build improved bottle container with animated wave
  Widget _buildBottleContainer(BuildContext context, double percentage) {
    return Container(
      width: 220,
      height: 300,
      decoration: BoxDecoration(
        // Gradient border - Fresh blue colors
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF80DEEA), // Light cyan
            Color(0xFF00D4FF), // Bright cyan
            Color(0xFF00BCD4), // Cyan
            Color(0xFF0099CC), // Deep cyan
          ],
        ),
        borderRadius: BorderRadius.circular(110),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withValues(alpha: 0.4),
            blurRadius: 25,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: const Color(0xFF00BCD4).withValues(alpha: 0.2),
            blurRadius: 40,
            spreadRadius: -5,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(108),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(108),
          child: Stack(
            children: [
              // Background gradient for empty part
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFE1F5FE), // Very light blue
                      Color(0xFFB3E5FC), // Light blue
                    ],
                  ),
                ),
              ),
              
              // Water fill with animated wave at top
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeInOutCubic,
                  height: 296 * percentage,
                  child: Stack(
                    children: [
                      // Main water body - Fresh gradient
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF80DEEA), // Light cyan top
                              Color(0xFF4DD0E1), // Cyan
                              Color(0xFF26C6DA), // Bright cyan
                              Color(0xFF00BCD4), // Deep cyan
                              Color(0xFF00ACC1), // Deep cyan bottom
                              Color(0xFF0097A7), // Darkest
                            ],
                            stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                          ),
                        ),
                      ),
                      
                      // Animated wave at the top - MULTIPLE LAYERS
                      if (percentage > 0) ...[
                        // Wave layer 1 - Deep cyan (most visible)
                        Positioned(
                          top: -5,
                          left: 0,
                          right: 0,
                          child: AnimatedBuilder(
                            animation: _waveController,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: WavePainter(
                                  animation: _waveController.value,
                                  color: const Color(0xFF0097A7), // Deep teal
                                  amplitude: 8,
                                  frequency: 2,
                                ),
                                size: const Size(212, 35),
                              );
                            },
                          ),
                        ),
                        // Wave layer 2 - Bright white foam
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: AnimatedBuilder(
                            animation: _waveController,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: WavePainter(
                                  animation: _waveController.value + 0.5,
                                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.7),
                                  amplitude: 6,
                                  frequency: 3,
                                ),
                                size: const Size(212, 30),
                              );
                            },
                          ),
                        ),
                        // Wave layer 3 - Bright cyan highlight
                        Positioned(
                          top: 2,
                          left: 0,
                          right: 0,
                          child: AnimatedBuilder(
                            animation: _waveController,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: WavePainter(
                                  animation: _waveController.value + 0.25,
                                  color: const Color(0xFF00E5FF).withValues(alpha: 0.6),
                                  amplitude: 5,
                                  frequency: 2.5,
                                ),
                                size: const Size(212, 25),
                              );
                            },
                          ),
                        ),
                      ],
                      
                      // Shimmer effect overlay
                      if (percentage > 0)
                        Positioned.fill(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: 0.2,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withValues(alpha: 0.0),
                                    Colors.white.withValues(alpha: 0.4),
                                    Colors.white.withValues(alpha: 0.0),
                                  ],
                                  stops: const [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ),
                      
                      // Bubbles effect
                      if (percentage > 0.1)
                        ..._buildBubbles(percentage),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build animated bubbles
  List<Widget> _buildBubbles(double percentage) {
    return List.generate(5, (index) {
      final delay = index * 0.2;
      return AnimatedBuilder(
        animation: _waveController,
        builder: (context, child) {
          final animValue = (_waveController.value + delay) % 1.0;
          final bottom = animValue * 296 * percentage;
          final opacity = 1.0 - animValue;
          
          return Positioned(
            bottom: bottom,
            left: 40.0 + (index * 30.0),
            child: Opacity(
              opacity: opacity * 0.6,
              child: Container(
                width: 8 + (index % 3) * 4,
                height: 8 + (index % 3) * 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  // Build splash effect
  Widget _buildSplashEffect() {
    return AnimatedBuilder(
      animation: _splashAnimation,
      builder: (context, child) {
        return Center(
          child: Transform.scale(
            scale: _splashAnimation.value,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstants.primaryColor.withValues(
                  alpha: (1.0 - _splashAnimation.value) * 0.5,
                ),
              ),
              child: const Center(
                child: Text(
                  '💧',
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Build center statistics
  Widget _buildCenterStats(BuildContext context, WaterProvider provider, double percentage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Amount dengan drop shadow
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: percentage > 0.3 
                ? Colors.white.withValues(alpha: 0.95)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: percentage > 0.3 ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ] : null,
          ),
          child: Column(
            children: [
              Text(
                '${provider.todayTotalMl}ml',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: percentage > 0.3 ? AppConstants.primaryColor : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 42,
                  shadows: percentage <= 0.3 ? [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ] : null,
                ),
              ),
              Text(
                '${provider.todayProgressPercentage.toStringAsFixed(0)}% of ${provider.dailyGoalMl}ml',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: percentage > 0.3 ? AppConstants.secondaryColor : Colors.white,
                  fontWeight: FontWeight.w600,
                  shadows: percentage <= 0.3 ? [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ] : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Build quick add buttons
  Widget _buildQuickAddButtons(BuildContext context, WaterProvider provider) {
    return Column(
      children: [
        // Quick buttons row
        Row(
          children: [
            Expanded(
              child: _buildQuickButton(
                context,
                provider,
                150,
                '150ml',
                Icons.local_cafe,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildQuickButton(
                context,
                provider,
                provider.glassSize,
                '${provider.glassSize}ml',
                Icons.water_drop,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildQuickButton(
                context,
                provider,
                500,
                '500ml',
                Icons.sports_bar,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Custom amount button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _showCustomAmountDialog(context, provider),
            icon: const Icon(Icons.edit),
            label: const Text('Custom Amount'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(
                color: AppConstants.primaryColor.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Build individual quick button
  Widget _buildQuickButton(
    BuildContext context,
    WaterProvider provider,
    int amount,
    String label,
    IconData icon,
  ) {
    return ElevatedButton(
      onPressed: () => _addWater(context, provider, amount),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Add water helper with splash animation
  Future<void> _addWater(
    BuildContext context,
    WaterProvider provider,
    int amount,
  ) async {
    // Trigger splash animation
    _triggerSplash();
    
    // Add water
    await provider.addWaterIntake(amount);
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              Text('Added ${amount}ml of water! 💧'),
            ],
          ),
          backgroundColor: AppConstants.successColor,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  // Show custom amount dialog
  Future<void> _showCustomAmountDialog(
    BuildContext context,
    WaterProvider provider,
  ) async {
    final controller = TextEditingController();
    String? selectedPreset;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.water_drop, color: AppConstants.primaryColor),
              SizedBox(width: 8),
              Text('Add Water Intake'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Select:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Preset chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: AppConstants.glassSizes.map((size) {
                    final isSelected = selectedPreset == size.toString();
                    return ChoiceChip(
                      label: Text('${size}ml'),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedPreset = size.toString();
                            controller.text = size.toString();
                          } else {
                            selectedPreset = null;
                          }
                        });
                      },
                      selectedColor: AppConstants.primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                
                const Text(
                  'Or enter custom amount:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Custom input
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount (ml)',
                    prefixIcon: Icon(Icons.water_drop),
                    suffixText: 'ml',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedPreset = null;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                final amount = int.tryParse(controller.text);
                
                if (amount != null && amount > 0 && amount <= 5000) {
                  Navigator.pop(context);
                  _addWater(context, provider, amount);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Please enter a valid amount (1-5000ml)'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ],
        ),
      ),
    );
    
    controller.dispose();
  }
}

// Custom painter untuk wave effect
class WavePainter extends CustomPainter {
  final double animation;
  final Color color;
  final double amplitude;
  final double frequency;

  WavePainter({
    required this.animation,
    required this.color,
    this.amplitude = 8.0,
    this.frequency = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final path = Path();
    
    // Start dari kiri bawah
    path.moveTo(0, size.height);

    // Buat wave dengan multiple frequencies untuk natural look
    for (double i = 0; i <= size.width; i += 0.5) {
      // Wave 1 - main wave
      final wave1 = math.sin(
        (i / size.width * 2 * math.pi * frequency) + 
        (animation * 2 * math.pi)
      );
      
      // Wave 2 - secondary wave (berbeda frekuensi)
      final wave2 = math.sin(
        (i / size.width * 2 * math.pi * (frequency * 1.5)) - 
        (animation * 2 * math.pi * 0.7)
      ) * 0.6;
      
      // Wave 3 - detail wave
      final wave3 = math.sin(
        (i / size.width * 2 * math.pi * (frequency * 3)) + 
        (animation * 2 * math.pi * 1.3)
      ) * 0.3;
      
      // Combine waves
      final combinedWave = wave1 + wave2 + wave3;
      final y = size.height / 2 + (combinedWave * amplitude);
      
      path.lineTo(i, y);
    }

    // Tutup path
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
    
    // Draw outline untuk emphasis
    final outlinePaint = Paint()
      ..color = color.withValues(alpha: math.min(color.a * 1.5, 1.0))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    
    final outlinePath = Path();
    outlinePath.moveTo(0, size.height / 2);
    
    for (double i = 0; i <= size.width; i += 0.5) {
      final wave1 = math.sin(
        (i / size.width * 2 * math.pi * frequency) + 
        (animation * 2 * math.pi)
      );
      final wave2 = math.sin(
        (i / size.width * 2 * math.pi * (frequency * 1.5)) - 
        (animation * 2 * math.pi * 0.7)
      ) * 0.6;
      final wave3 = math.sin(
        (i / size.width * 2 * math.pi * (frequency * 3)) + 
        (animation * 2 * math.pi * 1.3)
      ) * 0.3;
      
      final combinedWave = wave1 + wave2 + wave3;
      final y = size.height / 2 + (combinedWave * amplitude);
      
      outlinePath.lineTo(i, y);
    }
    
    canvas.drawPath(outlinePath, outlinePaint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}