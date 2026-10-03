import 'package:flutter/material.dart';

class CreateDeliveryScreen extends StatefulWidget {
  const CreateDeliveryScreen({super.key});
  @override
  State<CreateDeliveryScreen> createState() => _CreateDeliveryScreenState();
}

class _CreateDeliveryScreenState extends State<CreateDeliveryScreen> {
  final _pickupCtrl = TextEditingController();
  final _dropoffCtrl = TextEditingController();
  final _packageContentCtrl = TextEditingController();
  int _step = 0;
  String _selectedSize = 'SMALL';
  bool _loading = false;

  final List<Map<String, dynamic>> _sizes = [
    {'key': 'SMALL', 'label': 'Small', 'desc': 'Documents, phone, small items', 'icon': Icons.inventory_2_outlined},
    {'key': 'MEDIUM', 'label': 'Medium', 'desc': 'Shoes, clothing, mid-sized box', 'icon': Icons.inbox_outlined},
    {'key': 'LARGE', 'label': 'Large', 'desc': 'Appliances, large parcels', 'icon': Icons.local_shipping_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final charcoal = const Color(0xFF0F172A);
    final gold = const Color(0xFFD4AF37);
    return Scaffold(
      appBar: AppBar(
        title: Text(_step == 0 ? 'New Delivery' : _step == 1 ? 'Package Details' : 'Confirm Delivery'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _step > 0 ? setState(() => _step--) : Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Step indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: List.generate(3, (i) => Expanded(child: Row(children: [
                Expanded(child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 4,
                  decoration: BoxDecoration(
                    color: i <= _step ? charcoal : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                )),
                if (i < 2) const SizedBox(width: 4),
              ]))),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _step == 0 ? _stepAddresses(charcoal, gold)
                    : _step == 1 ? _stepPackageType(charcoal, gold)
                    : _stepConfirm(charcoal, gold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : () async {
                  if (_step < 2) {
                    setState(() => _step++);
                  } else {
                    setState(() => _loading = true);
                    await Future.delayed(const Duration(seconds: 1));
                    if (mounted) {
                      Navigator.pushNamed(context, '/searching-rider');
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: charcoal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _loading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text(_step < 2 ? 'Continue' : 'Find Riders', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepAddresses(Color charcoal, Color gold) {
    return Column(
      key: const ValueKey(0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Where are we picking up?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Enter pickup and drop-off addresses', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 32),
        _addressField('Pickup address', Icons.my_location, controller: _pickupCtrl, accentColor: charcoal),
        const SizedBox(height: 16),
        _addressField('Drop-off address', Icons.location_on, controller: _dropoffCtrl, accentColor: const Color(0xFFEF4444)),
        const SizedBox(height: 32),
        const Text('Saved Addresses', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        _savedAddress('Home', '12 Admiralty Way, Lekki', Icons.home_outlined),
        _savedAddress('Office', '3 Ozumba Mbadiwe, Victoria Island', Icons.business_outlined),
      ],
    );
  }

  Widget _stepPackageType(Color charcoal, Color gold) {
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Package size', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Select the size that best fits your item', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 32),
        ..._sizes.map((size) {
          final isSelected = _selectedSize == size['key'];
          return GestureDetector(
            onTap: () => setState(() => _selectedSize = size['key'] as String),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isSelected ? charcoal : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isSelected ? charcoal : const Color(0xFFE2E8F0), width: isSelected ? 2 : 1),
              ),
              child: Row(
                children: [
                  Icon(size['icon'] as IconData, color: isSelected ? gold : Colors.grey, size: 32),
                  const SizedBox(width: 16),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(size['label'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isSelected ? Colors.white : null)),
                      Text(size['desc'] as String, style: TextStyle(color: isSelected ? Colors.white70 : Colors.grey, fontSize: 13)),
                    ],
                  )),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 32),
        const Text('Package Contents (Required)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        const Text('For security, declare what is inside. Riders won\'t see this until they are hired.', style: TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 12),
        TextField(
          controller: _packageContentCtrl,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'E.g., 2 Laptops, legal documents, etc...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: charcoal, width: 2)),
            filled: true, fillColor: const Color(0xFFF8F9FA),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _stepConfirm(Color charcoal, Color gold) {
    final sizeData = _sizes.firstWhere((s) => s['key'] == _selectedSize);
    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Review & Confirm', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Make sure your details are correct', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 32),
        _confirmRow('Pickup', _pickupCtrl.text.isEmpty ? '123 Victoria Island, Lagos' : _pickupCtrl.text, Icons.my_location),
        _confirmRow('Drop-off', _dropoffCtrl.text.isEmpty ? 'Lekki Phase 1, Lagos' : _dropoffCtrl.text, Icons.location_on, iconColor: Colors.red),
        _confirmRow('Package Size', '${sizeData['label']}  (${sizeData['desc']})', Icons.inventory_2_outlined),
        _confirmRow('Declared Contents', _packageContentCtrl.text.isEmpty ? 'Not specified' : _packageContentCtrl.text, Icons.verified_user_outlined, iconColor: Colors.green),
        const Divider(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Rider Fee', style: TextStyle(fontSize: 16, color: Colors.grey)),
            Text('Open to Bids', style: TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: gold.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: gold.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: gold),
              const SizedBox(width: 12),
              const Expanded(child: Text('Riders will bid on your request. You can review their offers, ratings, and distances before accepting the best one.', style: TextStyle(fontSize: 13))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _addressField(String hint, IconData icon, {TextEditingController? controller, required Color accentColor}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: accentColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: accentColor, width: 2)),
        filled: true, fillColor: const Color(0xFFF8F9FA),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  Widget _savedAddress(String label, String address, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: const Color(0xFF0F172A)),
      ),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(address, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () => setState(() {
        _pickupCtrl.text = address;
      }),
    );
  }

  Widget _confirmRow(String label, String value, IconData icon, {Color? iconColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 22, color: iconColor ?? Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
