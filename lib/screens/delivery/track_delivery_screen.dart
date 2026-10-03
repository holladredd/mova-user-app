import 'package:flutter/material.dart';

import '../../data/mock_data.dart';

class TrackDeliveryScreen extends StatefulWidget {
  const TrackDeliveryScreen({super.key});
  @override
  State<TrackDeliveryScreen> createState() => _TrackDeliveryScreenState();
}

class _TrackDeliveryScreenState extends State<TrackDeliveryScreen> {
  final _trackCtrl = TextEditingController(text: 'MOVA-8392');
  bool _isTracking = true;
  Map<String, dynamic>? _delivery = MockData.allDeliveries.firstWhere((d) => d['trackingId'] == 'MOVA-8392');
  
  void _search() {
    setState(() {
      _isTracking = true;
      try {
        _delivery = MockData.allDeliveries.firstWhere((d) => d['trackingId'] == _trackCtrl.text.trim());
      } catch (e) {
        _delivery = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final charcoal = const Color(0xFF0F172A);
    final gold = const Color(0xFFD4AF37);
    return Scaffold(
      appBar: AppBar(title: const Text('Track Delivery')),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _trackCtrl,
                    decoration: InputDecoration(
                      hintText: 'Tracking ID',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                      filled: true, fillColor: const Color(0xFFF8F9FA),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _search,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: charcoal,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Track', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          if (_isTracking && _delivery != null) Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Mock map placeholder
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.map, size: 48, color: gold.withValues(alpha: 0.6)),
                              const SizedBox(height: 8),
                              const Text('Live Map Tracking', style: TextStyle(color: Colors.white70)),
                              const Text('(Available when connected to live backend)', style: TextStyle(color: Colors.white38, fontSize: 11)),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 16, right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: const Color(0xFF3B82F6), borderRadius: BorderRadius.circular(20)),
                            child: const Row(children: [
                              Icon(Icons.directions_bike, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text('In Transit', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Rider info
                  if (_delivery!['riderId'] != null) (() {
                    final rider = MockData.mockRiders.firstWhere((r) => r['id'] == _delivery!['riderId']);
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF1A1A1A) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
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
                                Text('${rider['firstName']} ${rider['lastName']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Row(children: [
                                  const Icon(Icons.star, color: Color(0xFFD4AF37), size: 14),
                                  const SizedBox(width: 4),
                                  Text('${rider['rating']}  ·  ${rider['vehicle']['make']} ${rider['vehicle']['type']} · ${rider['vehicle']['plateNumber']}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                ]),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              _iconCircle(Icons.phone, const Color(0xFF22C55E)),
                              const SizedBox(width: 8),
                              _iconCircle(Icons.message_outlined, charcoal),
                            ],
                          ),
                        ],
                      ),
                    );
                  })() else const Center(child: Text('Searching for nearest rider...')),
                  const SizedBox(height: 20),

                  // Timeline
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF1A1A1A) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Delivery Timeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 20),
                        ...List.generate((_delivery!['events'] as List).length, (i) {
                          final step = _delivery!['events'][i];
                          final isLast = i == (_delivery!['events'] as List).length - 1;
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 28, height: 28,
                                    decoration: BoxDecoration(
                                      color: step['done'] as bool ? charcoal : Colors.grey.shade200,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      step['done'] as bool ? Icons.check : Icons.circle,
                                      color: step['done'] as bool ? gold : Colors.grey.shade400,
                                      size: step['done'] as bool ? 16 : 8,
                                    ),
                                  ),
                                  if (!isLast) Container(
                                    width: 2, height: 40,
                                    color: step['done'] as bool ? charcoal.withValues(alpha: 0.2) : Colors.grey.shade200,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Text(step['label'] as String, style: TextStyle(fontWeight: FontWeight.bold, color: step['done'] as bool ? null : Colors.grey)),
                                        Text(step['time'] as String, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                      ]),
                                      const SizedBox(height: 2),
                                      Text(step['desc'] as String, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconCircle(IconData icon, Color color) {
    return Container(
      width: 40, height: 40,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}
