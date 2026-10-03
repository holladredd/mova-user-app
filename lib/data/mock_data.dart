class MockData {
  static const String mockUserId = 'usr_1';

  static const Map<String, dynamic> mockUser = {
    'id': mockUserId,
    'firstName': 'John',
    'lastName': 'Doe',
    'email': 'john@example.com',
    'phone': '+2348000000001',
    'walletBalance': 15000,
  };

  static const List<Map<String, dynamic>> mockRiders = [
    {
      'id': 'rid_1',
      'firstName': 'Emeka',
      'lastName': 'Adeyemi',
      'phone': '+2348000000002',
      'avatar': 'E',
      'vehicle': {'type': 'Bike', 'plateNumber': 'LGA-4821-BD', 'make': 'Kawasaki'},
      'rating': 4.9,
      'trips': 142,
      'balance': 8300,
    },
    {
      'id': 'rid_2',
      'firstName': 'Sarah',
      'lastName': 'Okonkwo',
      'phone': '+2348000000003',
      'avatar': 'S',
      'vehicle': {'type': 'Bike', 'plateNumber': 'KJA-1234-AB', 'make': 'Honda'},
      'rating': 4.7,
      'trips': 89,
      'balance': 4200,
    },
  ];

  static final List<Map<String, dynamic>> allDeliveries = [
    {
      'id': 'del_1',
      'trackingId': 'MOVA-8392',
      'status': 'IN_TRANSIT',
      'userId': 'usr_1',
      'riderId': 'rid_1',
      'pickupAddress': '12 Admiralty Way, Lekki Phase 1, Lagos',
      'dropoffAddress': '3 Ozumba Mbadiwe, Victoria Island, Lagos',
      'estimatedPrice': 2500,
      'distanceKm': 5.2,
      'package': {'category': 'electronics', 'size': 'SMALL', 'description': 'Laptop charger'},
      'recipient': {'name': 'Jane Smith', 'phone': '+2348000000004'},
      'events': [
        {'status': 'CREATED', 'label': 'Order Placed', 'time': '10:02 AM', 'desc': 'Your delivery request was received', 'done': true, 'icon': '📋'},
        {'status': 'RIDER_ASSIGNED', 'label': 'Rider Assigned', 'time': '10:08 AM', 'desc': 'Emeka A. accepted your order', 'done': true, 'icon': '🏍️'},
        {'status': 'PACKAGE_RECEIVED', 'label': 'Picked Up', 'time': '10:25 AM', 'desc': 'Package collected from pickup location', 'done': true, 'icon': '📦'},
        {'status': 'IN_TRANSIT', 'label': 'In Transit', 'time': '10:32 AM', 'desc': 'Rider is heading to your destination', 'done': true, 'icon': '🚀'},
        {'status': 'RIDER_ARRIVED_DESTINATION', 'label': 'Arriving Soon', 'time': '~10:47 AM', 'desc': 'Estimated 15 minutes away', 'done': false, 'icon': '📍'},
        {'status': 'COMPLETED', 'label': 'Delivered', 'time': '--', 'desc': 'Package will be delivered to your address', 'done': false, 'icon': '✅'}
      ],
      'createdAt': DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
    },
    {
      'id': 'del_2',
      'trackingId': 'MOVA-1145',
      'status': 'COMPLETED',
      'userId': 'usr_1',
      'riderId': 'rid_2',
      'pickupAddress': 'Ikeja City Mall, Ikeja',
      'dropoffAddress': 'Yaba, Lagos',
      'estimatedPrice': 3500,
      'distanceKm': 12.5,
      'package': {'category': 'clothing', 'size': 'MEDIUM', 'description': 'Two pairs of shoes'},
      'recipient': {'name': 'Michael O.', 'phone': '+2348000000005'},
      'events': [
        {'status': 'CREATED', 'label': 'Order Placed', 'time': 'Yesterday 2:00 PM', 'desc': 'Your delivery request was received', 'done': true, 'icon': '📋'},
        {'status': 'COMPLETED', 'label': 'Delivered', 'time': 'Yesterday 3:15 PM', 'desc': 'Package delivered successfully', 'done': true, 'icon': '✅'}
      ],
      'createdAt': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
    },
    {
      'id': 'del_3',
      'trackingId': 'MOVA-9921',
      'status': 'SEARCHING_RIDER',
      'userId': 'usr_1',
      'riderId': null,
      'pickupAddress': 'Gbagada Phase 2, Lagos',
      'dropoffAddress': 'Surulere, Lagos',
      'estimatedPrice': 1800,
      'distanceKm': 8.0,
      'package': {'category': 'documents', 'size': 'SMALL', 'description': 'Legal papers'},
      'recipient': {'name': 'Law Firm', 'phone': '+2348000000006'},
      'events': [
        {'status': 'CREATED', 'label': 'Order Placed', 'time': 'Just now', 'desc': 'Your delivery request was received', 'done': true, 'icon': '📋'},
        {'status': 'SEARCHING_RIDER', 'label': 'Searching for rider', 'time': '...', 'desc': 'Finding the nearest available rider', 'done': false, 'icon': '🔍'}
      ],
      'createdAt': DateTime.now().toIso8601String(),
    }
  ];

  static final List<Map<String, dynamic>> activeDeliveries = allDeliveries.where((d) => d['status'] != 'COMPLETED' && d['status'] != 'CANCELLED').toList();
  static final List<Map<String, dynamic>> recentDeliveries = allDeliveries.where((d) => d['status'] == 'COMPLETED' || d['status'] == 'CANCELLED').toList();

  static final List<Map<String, dynamic>> walletTransactions = [
    {'id': 'tx_1', 'type': 'CREDIT', 'amount': 20000, 'desc': 'Card funding', 'date': DateTime.now().subtract(const Duration(days: 2)).toIso8601String()},
    {'id': 'tx_2', 'type': 'DEBIT', 'amount': 2500, 'desc': 'Delivery MOVA-8392', 'date': DateTime.now().subtract(const Duration(hours: 1)).toIso8601String()},
    {'id': 'tx_3', 'type': 'DEBIT', 'amount': 3500, 'desc': 'Delivery MOVA-1145', 'date': DateTime.now().subtract(const Duration(days: 1)).toIso8601String()},
  ];

  static const List<Map<String, dynamic>> mockBids = [
    {
      'id': 'bid_1',
      'rider': {'name': 'Emeka A.', 'rating': 4.9, 'avatar': 'E', 'trips': 142},
      'price': 1800,
      'eta': '5 mins',
      'distance': '1.2 km away',
    },
    {
      'id': 'bid_2',
      'rider': {'name': 'Sarah O.', 'rating': 4.7, 'avatar': 'S', 'trips': 89},
      'price': 1500,
      'eta': '8 mins',
      'distance': '2.5 km away',
    },
    {
      'id': 'bid_3',
      'rider': {'name': 'David K.', 'rating': 4.5, 'avatar': 'D', 'trips': 45},
      'price': 2200,
      'eta': '3 mins',
      'distance': '0.5 km away',
    }
  ];
}
