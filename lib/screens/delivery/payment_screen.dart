import 'package:flutter/material.dart';
import '../../data/mock_data.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _processing = false;
  String _selectedPayment = 'wallet';

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFD4AF37);
    final charcoal = const Color(0xFF0F172A);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF050505) : const Color(0xFFF8F9FA);
    final cardBg = isDark ? const Color(0xFF1A1A1A) : Colors.white;

    // Get the accepted bid from args or fall back to first bid
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final bid = args ?? MockData.mockBids[1]; // Default to lowest bid
    final rider = bid['rider'] as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Confirm & Pay'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Rider summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDark ? Colors.white10 : Colors.transparent)),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: charcoal,
                    child: Text(rider['avatar'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(rider['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                        Row(children: [
                          Icon(Icons.star, color: gold, size: 14),
                          const SizedBox(width: 4),
                          Text('${rider['rating']}  ·  ${rider['trips']} trips  ·  ${bid['distance']}',
                              style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ]),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₦${bid['price']}', style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 22)),
                      Text('ETA: ${bid['eta']}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Escrow notice
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock_outline, color: Colors.blue, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Secure Escrow Payment', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                        SizedBox(height: 4),
                        Text(
                          'Your payment is held securely and only released to the rider after delivery is confirmed with the 4-digit code.',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Payment method
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 12),
            _paymentOption(cardBg, isDark, 'wallet', 'MOVA Wallet', '₦11,300 available', Icons.account_balance_wallet, gold),
            const SizedBox(height: 10),
            _paymentOption(cardBg, isDark, 'card', 'Debit Card', '**** **** **** 4567', Icons.credit_card, charcoal),

            const SizedBox(height: 28),

            // Order summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDark ? Colors.white10 : Colors.transparent)),
              child: Column(
                children: [
                  _summaryRow('Delivery Fee', '₦${bid['price']}'),
                  _summaryRow('Service Fee', '₦150'),
                  _summaryRow('Insurance', '₦50'),
                  const Divider(height: 20),
                  _summaryRow('Total', '₦${(bid['price'] as int) + 200}', bold: true, valueColor: gold),
                ],
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _processing ? null : () async {
                  setState(() => _processing = true);
                  await Future.delayed(const Duration(seconds: 2));
                  if (!context.mounted) return;
                  Navigator.pushReplacementNamed(context, '/track');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: charcoal,
                  disabledBackgroundColor: charcoal.withValues(alpha: 0.5),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _processing
                    ? const SizedBox(
                        width: 24, height: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : Text(
                        'Pay ₦${(bid['price'] as int) + 200} & Confirm',
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'By paying, you agree to MOVA\'s Terms of Service and this payment will be held in escrow.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption(Color cardBg, bool isDark, String key, String label, String sub, IconData icon, Color iconColor) {
    final selected = _selectedPayment == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = key),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? iconColor.withValues(alpha: 0.06) : cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? iconColor : (isDark ? Colors.white10 : const Color(0xFFE2E8F0)), width: selected ? 2 : 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Container(
              width: 22, height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? iconColor : Colors.transparent,
                border: Border.all(color: selected ? iconColor : Colors.grey, width: 2),
              ),
              child: selected ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: bold ? null : Colors.grey, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.w600, color: valueColor, fontSize: bold ? 17 : 14)),
        ],
      ),
    );
  }
}
