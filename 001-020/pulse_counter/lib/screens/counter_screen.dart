import 'package:flutter/material.dart';
import '../widgets/counter_display.dart';
import '../widgets/action_button.dart';
import '../theme/app_colors.dart';

/// CounterScreen - Screen utama aplikasi PulseCounter
/// 
/// Screen ini mengimplementasikan:
/// - State management dengan private variables
/// - Counter logic dengan increment, decrement, reset
/// - Multiple FloatingActionButtons dengan customization
/// - Brutalist UI design
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

/// Private state class dengan underscore
/// Mengelola state internal screen
class _CounterScreenState extends State<CounterScreen> {
  /// Private variable untuk menyimpan nilai counter
  /// underscore (_) membuat variable ini private
  /// Hanya bisa diakses dalam file ini
  int _counter = 0;

  /// Method untuk increment counter
  /// void: tidak return value
  /// Private method dengan underscore
  void _incrementCounter() {
    // setState: memberitahu Flutter untuk rebuild widget
    setState(() {
      // Increment nilai counter
      _counter++;
    });
  }

  /// Method untuk decrement counter
  /// Dengan validasi agar tidak negatif
  void _decrementCounter() {
    setState(() {
      // Cek apakah counter > 0 sebelum decrement
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  /// Method untuk reset counter ke 0
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar: navigation bar di atas
      appBar: AppBar(
        title: const Text('PULSE COUNTER'),
        // Border bawah untuk separation
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.black,
            height: 3, // Border tebal
          ),
        ),
      ),

      // Body: konten utama screen
      body: Center(
        // Center: memusatkan child widget
        child: Column(
          // mainAxisAlignment.center: pusatkan vertical
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            // Label "COUNT"
            const Text(
              'COUNT',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: AppColors.darkGrey,
                letterSpacing: 2, // Wide spacing untuk label
              ),
            ),
            
            // Spacing vertical
            const SizedBox(height: 24),
            
            // CounterDisplay widget dengan nilai _counter
            CounterDisplay(count: _counter),
            
            const SizedBox(height: 48),
            
            // Row untuk button actions horizontal
            Row(
              // mainAxisAlignment.center: pusatkan horizontal
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                // Button Decrement
                ActionButton(
                  icon: Icons.remove,
                  label: 'DECREASE',
                  onPressed: _decrementCounter,
                  heroTag: 'decrement', // Unique tag
                ),
                
                // Spacing horizontal antar button
                const SizedBox(width: 24),
                
                // Button Reset
                ActionButton(
                  icon: Icons.refresh,
                  label: 'RESET',
                  onPressed: _resetCounter,
                  heroTag: 'reset', // Unique tag
                ),
                
                const SizedBox(width: 24),
                
                // Button Increment
                ActionButton(
                  icon: Icons.add,
                  label: 'INCREASE',
                  onPressed: _incrementCounter,
                  heroTag: 'increment', // Unique tag
                ),
              ],
            ),
          ],
        ),
      ),

      // Bottom border untuk Scaffold
      bottomNavigationBar: Container(
        height: 3,
        color: AppColors.black,
      ),
    );
  }
}