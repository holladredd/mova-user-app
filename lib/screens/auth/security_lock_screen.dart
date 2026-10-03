import 'package:flutter/material.dart';

class SecurityLockScreen extends StatefulWidget {
  const SecurityLockScreen({super.key});

  @override
  State<SecurityLockScreen> createState() => _SecurityLockScreenState();
}

class _SecurityLockScreenState extends State<SecurityLockScreen> {
  String _pin = '';

  void _onKeypadTap(String value) {
    if (_pin.length < 4) {
      setState(() => _pin += value);
      if (_pin.length == 4) {
        _verifyPin();
      }
    }
  }

  void _onDelete() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  void _verifyPin() async {
    // Simulate verification
    await Future.delayed(const Duration(milliseconds: 300));
    if (_pin == '1234') { // Mock correct PIN
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect PIN'), backgroundColor: Colors.red),
        );
        setState(() => _pin = '');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final charcoal = const Color(0xFF0F172A);
    final gold = const Color(0xFFD4AF37);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF050505) : Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Icon(Icons.lock_outline, size: 60, color: charcoal),
            const SizedBox(height: 24),
            const Text('Enter Security PIN', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Enter your 4-digit PIN to access MOVA', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            
            // PIN Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 20, height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _pin.length ? charcoal : Colors.transparent,
                    border: Border.all(color: charcoal, width: 2),
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),

            // Fingerprint Button
            GestureDetector(
              onTap: () {
                // Simulate biometric success
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Column(
                children: [
                  Icon(Icons.fingerprint, size: 48, color: gold),
                  const SizedBox(height: 8),
                  const Text('Use Biometrics', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            
            const Spacer(),

            // Keypad
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  _keypadRow(['1', '2', '3']),
                  const SizedBox(height: 20),
                  _keypadRow(['4', '5', '6']),
                  const SizedBox(height: 20),
                  _keypadRow(['7', '8', '9']),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 70), // empty space
                      _keypadButton('0'),
                      SizedBox(
                        width: 70,
                        child: IconButton(
                          onPressed: _onDelete,
                          icon: const Icon(Icons.backspace_outlined, size: 28),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _keypadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((k) => _keypadButton(k)).toList(),
    );
  }

  Widget _keypadButton(String number) {
    return GestureDetector(
      onTap: () => _onKeypadTap(number),
      child: Container(
        width: 70, height: 70,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(number, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
