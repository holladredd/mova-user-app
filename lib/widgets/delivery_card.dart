import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class DeliveryCard extends StatelessWidget {
  final DeliveryModel delivery;
  final bool isCompact;

  const DeliveryCard({super.key, required this.delivery, this.isCompact = false});

  Color _statusColor(String status) {
    switch (status) {
      case 'IN_TRANSIT': return const Color(0xFF3B82F6);
      case 'DELIVERED': return const Color(0xFF22C55E);
      case 'PENDING': return const Color(0xFFD4AF37);
      case 'CANCELLED': return const Color(0xFFEF4444);
      default: return Colors.grey;
    }
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'IN_TRANSIT': return 'In Transit';
      case 'DELIVERED': return 'Delivered';
      case 'PENDING': return 'Pending';
      case 'CANCELLED': return 'Cancelled';
      default: return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final statusColor = _statusColor(delivery.status);

    if (isCompact) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(
                delivery.status == 'DELIVERED' ? Icons.check_circle_outline : Icons.cancel_outlined,
                color: statusColor, size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(delivery.trackingId, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(delivery.dropoffAddress, style: const TextStyle(color: Colors.grey, fontSize: 13), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₦${delivery.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                  child: Text(_statusLabel(delivery.status), style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // Full card for active deliveries
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(delivery.trackingId, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                child: Text(_statusLabel(delivery.status), style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _routeRow(Icons.my_location, delivery.pickupAddress),
          Padding(
            padding: const EdgeInsets.only(left: 11),
            child: Align(alignment: Alignment.centerLeft,
              child: SizedBox(height: 20, child: VerticalDivider(color: Colors.grey.shade300, thickness: 1.5))
            ),
          ),
          _routeRow(Icons.location_on, delivery.dropoffAddress, iconColor: const Color(0xFFEF4444)),
          const Divider(height: 24),
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFF0F172A),
                child: Text(delivery.riderName[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(delivery.riderName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  Row(children: [
                    const Icon(Icons.star, color: Color(0xFFD4AF37), size: 14),
                    const SizedBox(width: 2),
                    Text('${delivery.riderRating}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ]),
                ],
              ),
              const Spacer(),
              Row(children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text('ETA: ${delivery.estimatedTime}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _routeRow(IconData icon, String address, {Color? iconColor}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor ?? Colors.grey),
        const SizedBox(width: 10),
        Expanded(child: Text(address, style: const TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
