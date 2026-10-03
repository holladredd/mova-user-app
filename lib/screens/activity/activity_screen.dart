import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../widgets/delivery_card.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gold = const Color(0xFFD4AF37);
    final bg = isDark ? const Color(0xFF050505) : const Color(0xFFF8F9FA);

    final active = MockData.activeDeliveries;
    final recent = MockData.recentDeliveries;
    final all = [...active, ...recent];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('My Deliveries'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: gold,
          labelColor: gold,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'All'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active
          active.isEmpty
              ? _emptyState('No active deliveries', Icons.local_shipping_outlined)
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: active.length,
                  itemBuilder: (_, i) => DeliveryCard(delivery: active[i]),
                ),

          // Completed
          recent.isEmpty
              ? _emptyState('No completed deliveries', Icons.check_circle_outline)
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: recent.length,
                  itemBuilder: (_, i) => DeliveryCard(delivery: recent[i], isCompact: true),
                ),

          // All
          all.isEmpty
              ? _emptyState('No deliveries yet', Icons.inbox_outlined)
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: all.length,
                  itemBuilder: (_, i) => DeliveryCard(delivery: all[i], isCompact: i >= active.length),
                ),
        ],
      ),
    );
  }

  Widget _emptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(message, style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F172A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Send a Package', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
