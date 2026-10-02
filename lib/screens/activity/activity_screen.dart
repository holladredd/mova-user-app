import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../widgets/delivery_card.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final all = [...MockData.activeDeliveries, ...MockData.recentDeliveries];
    return Scaffold(
      appBar: AppBar(title: const Text('My Deliveries')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: all.length,
        itemBuilder: (context, i) => DeliveryCard(delivery: all[i]),
      ),
    );
  }
}
