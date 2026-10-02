import 'package:flutter/material.dart';
import '../../data/mock_data.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final charcoal = const Color(0xFF0F172A);
    final gold = const Color(0xFFD4AF37);
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Balance card
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                  colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text('MOVA Wallet', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    Icon(Icons.account_balance_wallet, color: gold),
                  ]),
                  const SizedBox(height: 20),
                  const Text('₦ 11,300', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('Available Balance', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  const SizedBox(height: 24),
                  Row(children: [
                    Expanded(child: _walletAction(Icons.add, 'Top Up', gold, charcoal, () {})),
                    const SizedBox(width: 12),
                    Expanded(child: _walletAction(Icons.send, 'Withdraw', Colors.white24, Colors.white, () {})),
                  ]),
                ],
              ),
            ),

            // Transactions
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 12),
            ...MockData.walletTransactions.map((t) {
              final isCredit = t['type'] == 'credit';
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                leading: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: (isCredit ? const Color(0xFF22C55E) : const Color(0xFFEF4444)).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isCredit ? const Color(0xFF22C55E) : const Color(0xFFEF4444), size: 20),
                ),
                title: Text(t['label'] as String, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(t['date'] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                trailing: Text(
                  '${isCredit ? '+' : '-'}₦${t['amount']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isCredit ? const Color(0xFF22C55E) : const Color(0xFFEF4444),
                    fontSize: 15,
                  ),
                ),
              );
            }),
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
}
