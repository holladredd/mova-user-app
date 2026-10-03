import 'package:flutter/material.dart';
import '../../data/mock_data.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final charcoal = const Color(0xFF0F172A);
    final gold = const Color(0xFFD4AF37);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF050505) : const Color(0xFFF8F9FA);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('My Wallet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Balance card
            Container(
              margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                  colors: [Color(0xFF0F172A), Color(0xFF1E3A5F)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: charcoal.withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 8)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text('MOVA Wallet', style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 1)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: gold.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                      child: Text('Active', style: TextStyle(color: gold, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  const Text('₦ 11,300.00', style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold)),
                  const Text('Available Balance', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  const SizedBox(height: 24),
                  Row(children: [
                    Expanded(child: _walletAction(Icons.add_circle_outline, 'Top Up', gold.withValues(alpha: 0.2), gold, () => _showTopUpModal(context))),
                    const SizedBox(width: 12),
                    Expanded(child: _walletAction(Icons.send_outlined, 'Transfer', Colors.white12, Colors.white, () {})),
                  ]),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Quick Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                _statCard('₦23,500', 'Total Spent', Colors.red, isDark),
                const SizedBox(width: 12),
                _statCard('12', 'Deliveries', Colors.blue, isDark),
                const SizedBox(width: 12),
                _statCard('₦1,200', 'Avg. Cost', gold, isDark),
              ]),
            ),

            const SizedBox(height: 28),

            // Transactions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('See all', style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            ...MockData.walletTransactions.map((t) {
              final isCredit = t['type'] == 'CREDIT';
              return Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: isDark ? Colors.white10 : Colors.transparent),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color: (isCredit ? Colors.green : Colors.red).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                          color: isCredit ? Colors.green : Colors.red, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t['desc'] as String, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text(
                            DateTime.parse(t['date'] as String).toString().substring(0, 16),
                            style: const TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${isCredit ? '+' : '-'}₦${t['amount']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isCredit ? Colors.green : Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _walletAction(IconData icon, String label, Color bg, Color fg, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: fg, size: 18),
      label: Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    );
  }

  Widget _statCard(String value, String label, Color color, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  void _showTopUpModal(BuildContext context) {
    final amtCtrl = TextEditingController();
    final amounts = [1000, 2000, 5000, 10000, 20000, 50000];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Top Up Wallet', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                const SizedBox(height: 8),
                const Text('How much would you like to add?', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: amounts.map((a) => GestureDetector(
                    onTap: () {
                      setModalState(() => amtCtrl.text = '$a');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: amtCtrl.text == '$a' ? const Color(0xFF0F172A) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('₦${a ~/ 1000}K', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: amtCtrl.text == '$a' ? Colors.white : const Color(0xFF0F172A),
                      )),
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: amtCtrl,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    prefixText: '₦ ',
                    hintText: 'Or enter custom amount',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('₦${amtCtrl.text} added to wallet!'), backgroundColor: Colors.green),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Proceed to Pay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
