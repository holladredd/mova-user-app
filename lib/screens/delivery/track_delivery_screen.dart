import 'package:flutter/material.dart';

class TrackDeliveryScreen extends StatefulWidget {
  const TrackDeliveryScreen({super.key});
  @override
  State<TrackDeliveryScreen> createState() => _TrackDeliveryScreenState();
}

class _TrackDeliveryScreenState extends State<TrackDeliveryScreen> {
  final _trackCtrl = TextEditingController(text: 'MOVA-8392');
  bool _isTracking = true;
  
  final List<Map<String, dynamic>> _steps = [
    {'label': 'Order Placed', 'time': '10:02 AM', 'desc': 'Your delivery request was received', 'done': true},
    {'label': 'Rider Assigned', 'time': '10:08 AM', 'desc': 'Emeka A. accepted your order', 'done': true},
    {'label': 'Picked Up', 'time': '10:25 AM', 'desc': 'Package collected from Victoria Island', 'done': true},
    {'label': 'In Transit', 'time': '10:32 AM', 'desc': 'Rider is heading to your destination', 'done': true},
    {'label': 'Arriving Soon', 'time': '~10:47 AM', 'desc': 'Estimated 15 minutes away', 'done': false},
    {'label': 'Delivered', 'time': '--', 'desc': 'Package will be delivered at your address', 'done': false},
  ];

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
                  onPressed: () => setState(() => _isTracking = true),
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

          if (_isTracking) Expanded(
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
                  Container(
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
                          child: const Text('E', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Emeka A.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Row(children: [
                                Icon(Icons.star, color: Color(0xFFD4AF37), size: 14),
                                SizedBox(width: 4),
                                Text('4.9  ·  Kawasaki Bike · LGA-4821-BD', style: TextStyle(color: Colors.grey, fontSize: 12)),
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
                  ),
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
                        ...List.generate(_steps.length, (i) {
                          final step = _steps[i];
                          final isLast = i == _steps.length - 1;
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
