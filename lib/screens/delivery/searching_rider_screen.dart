import 'package:flutter/material.dart';
import '../../data/mock_data.dart';

class SearchingRiderScreen extends StatefulWidget {
  const SearchingRiderScreen({super.key});

  @override
  State<SearchingRiderScreen> createState() => _SearchingRiderScreenState();
}

class _SearchingRiderScreenState extends State<SearchingRiderScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  final List<Map<String, dynamic>> _visibleBids = [];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _simulateIncomingBids();
  }

  void _simulateIncomingBids() async {
    for (int i = 0; i < MockData.mockBids.length; i++) {
      await Future.delayed(Duration(seconds: 2 + i));
      if (mounted) {
        setState(() {
          _visibleBids.add(MockData.mockBids[i]);
        });
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFD4AF37);
    final charcoal = const Color(0xFF0F172A);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Offers'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        color: isDark ? const Color(0xFF050505) : const Color(0xFFF8F9FA),
        child: Column(
          children: [
            // Radar Animation Top
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Container(
                              width: 50 + (_pulseController.value * 50),
                              height: 50 + (_pulseController.value * 50),
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: charcoal,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.search, size: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Broadcasting your request to nearby riders...', style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ),

            // Bids List
            Expanded(
              child: _visibleBids.isEmpty
                  ? Center(
                      child: Text('Waiting for riders to bid...', style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: _visibleBids.length,
                      itemBuilder: (context, index) {
                        final bid = _visibleBids[index];
                        final rider = bid['rider'];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                            border: Border.all(color: isDark ? Colors.white10 : Colors.transparent),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: charcoal,
                                    child: Text(rider['avatar'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(rider['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(Icons.star, color: gold, size: 14),
                                            const SizedBox(width: 4),
                                            Text('${rider['rating']} (${rider['trips']} trips)  ·  ${bid['distance']}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('₦${bid['price']}', style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 20)),
                                      Text('ETA: ${bid['eta']}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Accept bid and go to tracking
                                    Navigator.pushReplacementNamed(context, '/track');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: charcoal,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: const Text('Accept Offer', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
