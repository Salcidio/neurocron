// File: lib/screens/signin_screen.dart
import 'package:flakesmobile/auth/providers/auth_provider.dart';
import 'package:flakesmobile/auth/screens/login.dart';
import 'package:flakesmobile/parts/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+\$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= 8 && !_isCommonPassword(password);
  }

  bool _isCommonPassword(String password) {
    const commonPasswords = [
      '12345678',
      'password',
      '123456789',
      'qwerty',
      'abc123',
    ];
    return commonPasswords.contains(password);
  }

  void _onSubmit() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _emailError = _validateEmail(email) ? null : 'Invalid email address';
      _passwordError =
          _validatePassword(password)
              ? null
              : password.length < 8
              ? 'Password must be at least 8 characters'
              : 'Password is too common';
      _confirmPasswordError =
          (confirmPassword == password) ? null : 'Passwords do not match';
    });

    if (_emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null) {
      ref.read(authProvider.notifier).signUp(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Text(
                    'Register',
                    style: GoogleFonts.tektur(fontSize: 40, color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'Welcome to the future\nFlake AI',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSerif(fontSize: 30),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _socialLoginButton(
                      icon: Icons.facebook,
                      text: 'Facebook',
                      onTap: () {},
                    ),
                    const SizedBox(width: 10),
                    _socialLoginButton(
                      icon: Icons.g_mobiledata,
                      text: 'Google',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Or'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  obscureText: false,
                  errorText: _emailError,
                  iconData: Icons.account_box_rounded,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  obscureText: true,
                  errorText: _passwordError,
                  iconData: Icons.password_outlined,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm your password',
                  obscureText: true,
                  errorText: _confirmPasswordError,
                  iconData: Icons.password_outlined,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A4CE1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                    ),
                    onPressed: isLoading ? null : _onSubmit,
                    child:
                        isLoading
                            ? LoadingAnimationWidget.threeArchedCircle(
                              color: Colors.white,
                              size: 30,
                            )
                            : const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("I have an account "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Color(0xFF1A4CE1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F6FD),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.grey.shade800),
              const SizedBox(width: 6),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
