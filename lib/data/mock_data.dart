class DeliveryModel {
  final String id;
  final String trackingId;
  final String status;
  final String pickupAddress;
  final String dropoffAddress;
  final String packageSize;
  final double price;
  final String riderName;
  final double riderRating;
  final String estimatedTime;
  final DateTime createdAt;

  const DeliveryModel({
    required this.id,
    required this.trackingId,
    required this.status,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.packageSize,
    required this.price,
    required this.riderName,
    required this.riderRating,
    required this.estimatedTime,
    required this.createdAt,
  });
}

class MockData {
  static final activeDeliveries = [
    DeliveryModel(
      id: '1',
      trackingId: 'MOVA-8392',
      status: 'IN_TRANSIT',
      pickupAddress: '123 Victoria Island, Lagos',
      dropoffAddress: 'Lekki Phase 1, Lagos',
      packageSize: 'SMALL',
      price: 1500,
      riderName: 'Emeka A.',
      riderRating: 4.9,
      estimatedTime: '15 mins',
      createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
    ),
  ];

  static final recentDeliveries = [
    DeliveryModel(
      id: '2',
      trackingId: 'MOVA-8391',
      status: 'DELIVERED',
      pickupAddress: 'Ikeja, Lagos',
      dropoffAddress: 'Yaba, Lagos',
      packageSize: 'MEDIUM',
      price: 2200,
      riderName: 'Tunde B.',
      riderRating: 4.7,
      estimatedTime: 'Delivered',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    DeliveryModel(
      id: '3',
      trackingId: 'MOVA-8388',
      status: 'DELIVERED',
      pickupAddress: 'Surulere, Lagos',
      dropoffAddress: 'Ikorodu, Lagos',
      packageSize: 'LARGE',
      price: 3800,
      riderName: 'Chidi K.',
      riderRating: 4.8,
      estimatedTime: 'Delivered',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    DeliveryModel(
      id: '4',
      trackingId: 'MOVA-8377',
      status: 'CANCELLED',
      pickupAddress: 'Oshodi, Lagos',
      dropoffAddress: 'Gbagada, Lagos',
      packageSize: 'SMALL',
      price: 1200,
      riderName: 'N/A',
      riderRating: 0,
      estimatedTime: 'Cancelled',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  static final walletTransactions = [
    {'type': 'credit', 'amount': 5000, 'label': 'Wallet Top-up', 'date': '2 days ago'},
    {'type': 'debit', 'amount': 1500, 'label': 'Delivery MOVA-8392', 'date': 'Today'},
    {'type': 'debit', 'amount': 2200, 'label': 'Delivery MOVA-8391', 'date': 'Yesterday'},
    {'type': 'credit', 'amount': 10000, 'label': 'Wallet Top-up', 'date': '5 days ago'},
    {'type': 'debit', 'amount': 3800, 'label': 'Delivery MOVA-8388', 'date': '3 days ago'},
  ];
}
