import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFD4AF37);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF050505) : const Color(0xFFF8F9FA);
    final cardBg = isDark ? const Color(0xFF1A1A1A) : Colors.white;

    final notifications = [
      {
        'icon': Icons.local_shipping_outlined,
        'color': Colors.blue,
        'title': 'Rider Accepted Your Request',
        'body': 'Emeka A. is heading to your pickup location.',
        'time': '2 mins ago',
        'read': false,
      },
      {
        'icon': Icons.monetization_on_outlined,
        'color': Colors.green,
        'title': 'Payment Successful',
        'body': 'Your wallet was debited ₦2,500 for delivery MOVA-8392.',
        'time': '10 mins ago',
        'read': false,
      },
      {
        'icon': Icons.check_circle_outline,
        'color': Colors.green,
        'title': 'Delivery Completed',
        'body': 'Your package has been delivered. Rate your rider!',
        'time': '1 hour ago',
        'read': true,
      },
      {
        'icon': Icons.star_outline,
        'color': gold,
        'title': 'New Bid Received',
        'body': 'Sarah O. placed a bid of ₦1,500 on your delivery request.',
        'time': '2 hours ago',
        'read': true,
      },
      {
        'icon': Icons.account_balance_wallet_outlined,
        'color': Colors.purple,
        'title': 'Wallet Topped Up',
        'body': '₦20,000 has been added to your MOVA wallet.',
        'time': 'Yesterday',
        'read': true,
      },
      {
        'icon': Icons.security_outlined,
        'color': Colors.orange,
        'title': 'Security Code Sent',
        'body': 'Your pickup verification code is: 1234. Share with your rider.',
        'time': 'Yesterday',
        'read': true,
      },
    ];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Mark all read', style: TextStyle(color: gold, fontSize: 13)),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text('No notifications yet', style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, i) {
                final n = notifications[i];
                final isRead = n['read'] as bool;
                return Container(
                  margin: EdgeInsets.fromLTRB(16, i == 0 ? 16 : 0, 16, 10),
                  decoration: BoxDecoration(
                    color: isRead ? cardBg : (n['color'] as Color).withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: isRead
                        ? Border.all(color: isDark ? Colors.white10 : Colors.transparent)
                        : Border.all(color: (n['color'] as Color).withValues(alpha: 0.3)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      width: 48, height: 48,
                      decoration: BoxDecoration(
                        color: (n['color'] as Color).withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(n['icon'] as IconData, color: n['color'] as Color, size: 24),
                    ),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            n['title'] as String,
                            style: TextStyle(fontWeight: isRead ? FontWeight.w500 : FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8, height: 8,
                            margin: const EdgeInsets.only(top: 4, left: 6),
                            decoration: BoxDecoration(color: n['color'] as Color, shape: BoxShape.circle),
                          ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(n['body'] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(n['time'] as String, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
