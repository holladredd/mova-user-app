import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  bool _agreed = false;

  void _register() async {
    if (!_agreed) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final charcoal = const Color(0xFF0F172A);
    final gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back, size: 20),
                ),
              ),
              const SizedBox(height: 32),
              const Text('Create account', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const SizedBox(height: 8),
              const Text('Join MOVA and start moving things', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 40),
              Row(children: [
                Expanded(child: _buildField('First Name', Icons.person_outline, controller: _firstNameCtrl)),
                const SizedBox(width: 16),
                Expanded(child: _buildField('Last Name', Icons.person_outline, controller: _lastNameCtrl)),
              ]),
              const SizedBox(height: 16),
              _buildField('Email address', Icons.email_outlined, controller: _emailCtrl, type: TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildField('Phone number', Icons.phone_outlined, controller: _phoneCtrl, type: TextInputType.phone),
              const SizedBox(height: 16),
              _buildField('Password', Icons.lock_outline, controller: _passCtrl, obscure: _obscure, suffix: IconButton(
                icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey),
                onPressed: () => setState(() => _obscure = !_obscure),
              )),
              const SizedBox(height: 24),
              Row(
                children: [
                  Checkbox(
                    value: _agreed,
                    activeColor: charcoal,
                    onChanged: (v) => setState(() => _agreed = v ?? false),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  const Expanded(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: 'I agree to the ', style: TextStyle(color: Colors.grey)),
                      TextSpan(text: 'Terms of Service', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      TextSpan(text: ' and ', style: TextStyle(color: Colors.grey)),
                      TextSpan(text: 'Privacy Policy', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    ])),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_loading || !_agreed) ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: charcoal,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _loading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                    child: Text('Sign in', style: TextStyle(color: charcoal, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, IconData icon, {
    TextEditingController? controller,
    bool obscure = false,
    Widget? suffix,
    TextInputType type = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: type,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey, size: 20),
            suffixIcon: suffix,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF0F172A), width: 2)),
            filled: true, fillColor: const Color(0xFFF8F9FA),
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
        ),
      ],
    );
  }
}
