import 'package:flutter/material.dart';

class SearchingRiderScreen extends StatefulWidget {
  const SearchingRiderScreen({super.key});

  @override
  State<SearchingRiderScreen> createState() => _SearchingRiderScreenState();
}

class _SearchingRiderScreenState extends State<SearchingRiderScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Mock finding a rider after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Navigate to tracking screen or home
        Navigator.pushReplacementNamed(context, '/track');
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFD4AF37);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Radar Animation Placeholder
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: 100 + (_pulseController.value * 100),
                        height: 100 + (_pulseController.value * 100),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: gold.withValues(alpha: 0.1 * (1 - _pulseController.value)),
                          border: Border.all(
                            color: gold.withValues(alpha: 0.5 * (1 - _pulseController.value)),
                            width: 2,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(Icons.search, size: 40, color: gold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Finding the nearest rider...',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Please wait while we match your delivery request with an available rider nearby.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 60),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cancel
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Cancel Request', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
