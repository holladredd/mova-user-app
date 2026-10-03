import 'package:flutter/material.dart';

class DeliveryReviewScreen extends StatefulWidget {
  const DeliveryReviewScreen({super.key});
  @override
  State<DeliveryReviewScreen> createState() => _DeliveryReviewScreenState();
}

class _DeliveryReviewScreenState extends State<DeliveryReviewScreen> {
  int _rating = 0;
  final _commentCtrl = TextEditingController();
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFD4AF37);
    final charcoal = const Color(0xFF0F172A);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_submitted) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: const Icon(Icons.check_circle, color: Colors.green, size: 60),
              ),
              const SizedBox(height: 24),
              const Text('Delivery Complete!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Thank you for using MOVA', style: TextStyle(color: Colors.grey.shade600)),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: charcoal,
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Back to Home', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF050505) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Rate Your Rider'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Delivery success banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.green, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Package Delivered!', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                        Text('Code verified. Rider payment released.', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),

            CircleAvatar(
              radius: 50,
              backgroundColor: charcoal,
              child: const Text('E', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            const Text('Emeka Adeyemi', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: gold, size: 16),
                const SizedBox(width: 4),
                const Text('4.9  •  142 trips', style: TextStyle(color: Colors.grey)),
              ],
            ),

            const SizedBox(height: 40),
            const Text('How was your experience?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) => GestureDetector(
                onTap: () => setState(() => _rating = i + 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(i < _rating ? Icons.star : Icons.star_border, color: gold, size: 44),
                ),
              )),
            ),
            const SizedBox(height: 8),
            Text(
              _rating == 0 ? 'Tap a star to rate' : ['', 'Very Bad', 'Bad', 'Okay', 'Good', 'Excellent'][_rating],
              style: TextStyle(color: _rating > 0 ? gold : Colors.grey, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 32),
            TextField(
              controller: _commentCtrl,
              maxLines: 4,
              style: const TextStyle(color: Color(0xFF0F172A)),
              decoration: InputDecoration(
                hintText: 'Add a comment (optional)',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF0F172A), width: 2)),
                filled: true,
                fillColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
              ),
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _rating == 0 ? null : () => setState(() => _submitted = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: charcoal,
                  disabledBackgroundColor: Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Submit Review', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false),
              child: const Text('Skip for now', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
