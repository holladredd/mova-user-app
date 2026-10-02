import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final charcoal = const Color(0xFF0F172A);
    final gold = const Color(0xFFD4AF37);
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Avatar
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(radius: 52, backgroundColor: charcoal,
                        child: const Text('A', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      Positioned(
                        bottom: 0, right: 0,
                        child: Container(
                          width: 32, height: 32,
                          decoration: BoxDecoration(color: gold, shape: BoxShape.circle),
                          child: const Icon(Icons.edit, color: Colors.black, size: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Alex Doe', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const Text('alex.doe@email.com', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(color: gold.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.verified, color: gold, size: 16),
                      const SizedBox(width: 4),
                      Text('Verified Account', style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 13)),
                    ]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _stat('12', 'Deliveries'),
                  _stat('₦23,500', 'Total Spent'),
                  _stat('4.8', 'Rating'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Menu items
            _section('Account', [
              _menuItem(Icons.person_outline, 'Personal Information', onTap: () {}),
              _menuItem(Icons.location_on_outlined, 'Saved Addresses', onTap: () {}),
              _menuItem(Icons.notifications_outlined, 'Notifications', onTap: () {}),
              _menuItem(Icons.language, 'Language', trailing: 'English', onTap: () {}),
            ]),
            _section('Support', [
              _menuItem(Icons.help_outline, 'Help & Support', onTap: () {}),
              _menuItem(Icons.privacy_tip_outlined, 'Privacy Policy', onTap: () {}),
              _menuItem(Icons.description_outlined, 'Terms of Service', onTap: () {}),
            ]),
            _section('', [
              _menuItem(Icons.logout, 'Sign Out', color: Colors.red,
                onTap: () => Navigator.pushReplacementNamed(context, '/login')),
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
        ...items,
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _menuItem(IconData icon, String label, {String? trailing, VoidCallback? onTap, Color? color}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(fontWeight: FontWeight.w500, color: color)),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        if (trailing != null) Text(trailing, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(width: 4),
        const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      ]),
      onTap: onTap,
    );
  }
}
