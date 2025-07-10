// File: lib/screens/signin_screen.dart
import 'package:flakesmobile/LLM/flakes.dart';
import 'package:flakesmobile/auth/providers/auth_provider.dart';
import 'package:flakesmobile/auth/screens/register.dart';
import 'package:flakesmobile/parts/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

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

    setState(() {
      _emailError = _validateEmail(email) ? null : 'Invalid email address';
      _passwordError =
          _validatePassword(password)
              ? null
              : password.length < 8
              ? 'Password must be at least 8 characters'
              : 'Password is too common';
    });

    if (_emailError == null && _passwordError == null) {
      ref.read(authProvider.notifier).signIn(email, password);
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
                    'Sign In',
                    style: GoogleFonts.tektur(fontSize: 40, color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'The way to dream.\nFlake company',
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
                      icon: Icons.gite_outlined,
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
                  errorText: _emailError,
                  obscureText: false,
                  iconData: Icons.account_box_rounded,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  errorText: _passwordError,
                  obscureText: true,
                  iconData: Icons.password_outlined,
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Color(0xFF1A4CE1),
                      backgroundColor: const Color(0xFF1A4CE1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                    ),
                    onPressed:
                        isLoading
                            ? null
                            : () {
                              _onSubmit();
                            },
                    child:
                        isLoading
                            ? LoadingAnimationWidget.threeArchedCircle(
                              color: Colors.white,
                              size: 30,
                            )
                            : const Text(
                              'Log In',
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
                    const Text("Don't have account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
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
