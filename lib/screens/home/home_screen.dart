import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/mock_data.dart';
import '../../widgets/delivery_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _HomeTab(),
    const ActivityTab(),
    const WalletTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        selectedItemColor: const Color(0xFFD4AF37),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), activeIcon: Icon(Icons.list_alt), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), activeIcon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gold = const Color(0xFFD4AF37);
    final charcoal = const Color(0xFF0F172A);
    final cardBg = isDark ? const Color(0xFF1A1A1A) : Colors.white;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: charcoal,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset('assets/logo-dark.svg', height: 36),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/notifications'),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 44, height: 44,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.1)),
                                    child: const Icon(Icons.notifications_outlined, color: Colors.white),
                                  ),
                                  Positioned(
                                    top: 8, right: 8,
                                    child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text('Good morning, ${MockData.mockUser['firstName']} 👋', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 4),
                        const Text('Where are we sending today?', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick actions
                  Row(
                    children: [
                      Expanded(child: _ActionCard(
                        icon: Icons.add_circle_outline, label: 'Send Item',
                        bg: charcoal, fg: Colors.white,
                        onTap: () => Navigator.pushNamed(context, '/create-delivery'),
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: _ActionCard(
                        icon: Icons.location_searching_rounded, label: 'Track',
                        bg: gold, fg: charcoal,
                        onTap: () => Navigator.pushNamed(context, '/track'),
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: _ActionCard(
                        icon: Icons.history, label: 'History',
                        bg: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF1F5F9),
                        fg: isDark ? Colors.white : charcoal,
                        onTap: () {},
                      )),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Promo banner
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFC5A059)]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('First delivery FREE!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                              SizedBox(height: 4),
                              Text('Use code MOVA2024 at checkout', style: TextStyle(color: Colors.black54, fontSize: 13)),
                            ],
                          ),
                        ),
                        const Icon(Icons.local_offer, color: Colors.black54, size: 40),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Active deliveries
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Active Deliveries', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      TextButton(onPressed: () {}, child: const Text('See all', style: TextStyle(color: Color(0xFFD4AF37)))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...MockData.activeDeliveries.map((d) => DeliveryCard(delivery: d)),
                  const SizedBox(height: 32),

                  // Recent
                  const Text('Recent Deliveries', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...MockData.recentDeliveries.map((d) => DeliveryCard(delivery: d, isCompact: true)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;
  const _ActionCard({required this.icon, required this.label, required this.bg, required this.fg, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Icon(icon, color: fg, size: 28),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

// Placeholder tabs — actual screens are imported
class ActivityTab extends StatelessWidget {
  const ActivityTab({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Activity')));
  }
}

class WalletTab extends StatelessWidget {
  const WalletTab({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Wallet')));
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Profile')));
  }
}
