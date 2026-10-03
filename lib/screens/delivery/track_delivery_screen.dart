import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/mock_data.dart';

class TrackDeliveryScreen extends StatefulWidget {
  const TrackDeliveryScreen({super.key});
  @override
  State<TrackDeliveryScreen> createState() => _TrackDeliveryScreenState();
}

class _TrackDeliveryScreenState extends State<TrackDeliveryScreen> {
  Map<String, dynamic>? _delivery = MockData.allDeliveries.firstWhere((d) => d['trackingId'] == 'MOVA-8392');

  // The two security codes
  static const String _pickupCode = '1234';  // Sender shares this with rider at pickup
  static const String _deliveryCode = '9876'; // Receiver shares this with rider at dropoff

  @override
  Widget build(BuildContext context) {
    final charcoal = const Color(0xFF0F172A);
    final gold = const Color(0xFFD4AF37);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final bg = isDark ? const Color(0xFF050505) : const Color(0xFFF8F9FA);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Track Delivery'),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/review'),
            icon: const Icon(Icons.check_circle_outline, color: Colors.green, size: 18),
            label: const Text('Delivered?', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map placeholder
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: charcoal.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 5))],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.navigation, size: 48, color: gold.withValues(alpha: 0.8)),
                        const SizedBox(height: 8),
                        const Text('Rider in transit...', style: TextStyle(color: Colors.white70, fontSize: 16)),
                        const Text('Live map available after backend connection', style: TextStyle(color: Colors.white38, fontSize: 11)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 14, right: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                      child: const Row(children: [
                        Icon(Icons.directions_bike, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text('In Transit', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ]),
                    ),
                  ),
                  Positioned(
                    bottom: 14, left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                      child: const Text('ETA: ~12 mins', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Security Codes Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // PICKUP CODE (Sender → Rider)
                  _codeCard(
                    context,
                    cardBg,
                    title: 'Pickup Code',
                    subtitle: 'Share this code with the rider when they arrive to pick up your package.',
                    code: _pickupCode,
                    icon: Icons.local_shipping_outlined,
                    color: const Color(0xFF3B82F6),
                  ),
                  const SizedBox(height: 12),
                  // DELIVERY CODE (Receiver keeps this — used at dropoff)
                  _codeCard(
                    context,
                    cardBg,
                    title: 'Delivery Code',
                    subtitle: 'Share this code with the receiver. Rider must enter it at delivery to confirm.',
                    code: _deliveryCode,
                    icon: Icons.person_pin_circle_outlined,
                    color: Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Rider info
            if (_delivery!['riderId'] != null) (() {
              final rider = MockData.mockRiders.firstWhere((r) => r['id'] == _delivery!['riderId']);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isDark ? Colors.white10 : Colors.transparent)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: charcoal,
                        child: Text(rider['avatar'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
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
                              Expanded(
                                child: Text(
                                  '${rider['rating']}  ·  ${rider['vehicle']['make']} ${rider['vehicle']['type']} · ${rider['vehicle']['plateNumber']}',
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                      Row(children: [
                        _iconCircle(Icons.phone, const Color(0xFF22C55E)),
                        const SizedBox(width: 8),
                        _iconCircle(Icons.message_outlined, charcoal),
                      ]),
                    ],
                  ),
                ),
              );
            })(),

            const SizedBox(height: 20),

            // Timeline
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? Colors.white10 : Colors.transparent)),
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
                              if (!isLast) Container(width: 2, height: 40, color: step['done'] as bool ? charcoal.withValues(alpha: 0.2) : Colors.grey.shade200),
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
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _codeCard(BuildContext context, Color cardBg, {
    required String title,
    required String subtitle,
    required String code,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: code.split('').map((digit) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 50, height: 56,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color.withValues(alpha: 0.4)),
                  ),
                  child: Center(
                    child: Text(digit, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
                  ),
                )).toList(),
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title copied!'), duration: const Duration(seconds: 1)),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    Icon(Icons.copy, color: color, size: 16),
                    const SizedBox(width: 4),
                    Text('Copy', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
                  ]),
                ),
              ),
            ],
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
