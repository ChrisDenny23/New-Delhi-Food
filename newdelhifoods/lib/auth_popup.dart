// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'dart:ui';
import 'package:newdelhifoods/config.dart';

class AuthPopup {
  static Future<void> showAuthModal(
    BuildContext context, {
    bool isLogin = true,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return ScaleTransition(
          scale: Tween(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation1, curve: Curves.easeOutCubic),
          ),
          child: FadeTransition(
            opacity: animation1,
            child: Center(
              child: Material(
                type: MaterialType.transparency,
                child: AuthModalContent(initialIsLogin: isLogin),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AuthModalContent extends StatefulWidget {
  final bool initialIsLogin;

  const AuthModalContent({super.key, this.initialIsLogin = true});

  @override
  State<AuthModalContent> createState() => _AuthModalContentState();
}

class _AuthModalContentState extends State<AuthModalContent>
    with SingleTickerProviderStateMixin {
  late bool _isLogin;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _storage = const FlutterSecureStorage();

  late Dio _dio;
  late CookieJar _cookieJar;

  bool _obscurePassword = true;
  bool _isLoading = false;

  // Replace with your actual backend URL

  @override
  void initState() {
    super.initState();
    _isLogin = widget.initialIsLogin;

    // Initialize Dio with conditional cookie support
    _cookieJar = CookieJar();
    _dio = Dio();

    // Only add CookieManager on non-web platforms
    if (!kIsWeb) {
      _dio.interceptors.add(CookieManager(_cookieJar));
    }

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
    _animationController.reset();
    _animationController.forward();
  }

  Future<void> _login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$apiBaseUrl/auth/login',
        data: {'email': email, 'password': password},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          // Enable sending/receiving cookies on web
          extra: {'withCredentials': true},
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        // Store access token in secure storage
        await _storage.write(
          key: 'access_token',
          value: response.data['accessToken'],
        );

        // Show success message
        _showMessage('Login successful!', isSuccess: true);

        // Close modal
        Navigator.of(context).pop();
      } else {
        // Handle login error
        String errorMessage = response.data['error'] ?? 'Login failed';
        _showMessage(errorMessage, isSuccess: false);
      }
    } on DioException catch (e) {
      String errorMessage = 'Network error. Please check your connection.';

      if (e.response != null) {
        if (e.response?.data != null && e.response?.data['error'] != null) {
          errorMessage = e.response?.data['error'];
        } else if (e.response?.statusCode == 401) {
          errorMessage = 'Invalid email or password';
        } else if (e.response?.statusCode == 400) {
          errorMessage = 'Please check your email and password';
        }
      }

      _showMessage(errorMessage, isSuccess: false);
    } catch (e) {
      _showMessage(
        'An unexpected error occurred. Please try again.',
        isSuccess: false,
      );
    }
  }

  Future<void> _signup(String name, String email, String password) async {
    try {
      final response = await _dio.post(
        '$apiBaseUrl/auth/signup',
        data: {
          'email': email,
          'password': password,
          'userdata': {'name': name},
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
          // Enable sending/receiving cookies on web
          extra: {'withCredentials': true},
        ),
      );

      if (response.statusCode == 201 && response.data['success'] == true) {
        // Store access token in secure storage if provided
        if (response.data['accessToken'] != null) {
          await _storage.write(
            key: 'access_token',
            value: response.data['accessToken'],
          );
        }

        // Show success message
        _showMessage(
          response.data['message'] ?? 'Account created successfully!',
          isSuccess: true,
        );

        // Close modal
        Navigator.of(context).pop();
      } else {
        // Handle signup error
        String errorMessage = response.data['error'] ?? 'Signup failed';
        _showMessage(errorMessage, isSuccess: false);
      }
    } on DioException catch (e) {
      String errorMessage = 'Network error. Please check your connection.';

      if (e.response != null) {
        if (e.response?.data != null && e.response?.data['error'] != null) {
          errorMessage = e.response?.data['error'];
        } else if (e.response?.statusCode == 400) {
          errorMessage = 'Please check your information and try again';
        }
      }

      _showMessage(errorMessage, isSuccess: false);
    } catch (e) {
      _showMessage(
        'An unexpected error occurred. Please try again.',
        isSuccess: false,
      );
    }
  }

  void _showMessage(String message, {required bool isSuccess}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess
            ? const Color(0xFF9ACD32)
            : Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        if (_isLogin) {
          await _login(_emailController.text.trim(), _passwordController.text);
        } else {
          await _signup(
            _nameController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text,
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 0,
                vertical: 40,
              ),
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 420,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: _buildGlassContainer(isMobile),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGlassContainer(bool isMobile) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 28 : 36),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.25),
                Colors.white.withOpacity(0.15),
                Colors.white.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildForm(),
                const SizedBox(height: 24),
                _buildToggleAuth(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Close button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 40),
            // Logo with glass effect
            _buildCloseButton(),
          ],
        ),

        const SizedBox(height: 20),

        Text(
          'New Delhi Foods',
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        Text(
          _isLogin
              ? 'Welcome back! Sign in to continue.'
              : 'Join us today and discover amazing flavors.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCloseButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: Colors.white, size: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Name field (only for signup)
          if (!_isLogin) ...[
            _buildGlassTextField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person_outline_rounded,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                if (value.length < 2) {
                  return 'Name must be at least 2 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
          ],

          // Email field
          _buildGlassTextField(
            controller: _emailController,
            label: 'Email Address',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          const SizedBox(height: 18),

          // Password field
          _buildGlassTextField(
            controller: _passwordController,
            label: 'Password',
            icon: Icons.lock_outline_rounded,
            obscureText: _obscurePassword,
            suffixIcon: _buildPasswordToggle(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (!_isLogin && value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),

          const SizedBox(height: 24),

          // Submit button
          _buildGlassSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: validator,
            style: const TextStyle(color: Colors.white, fontSize: 15),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF9ACD32).withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: suffixIcon,
                    )
                  : null,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              errorStyle: TextStyle(color: Colors.red.shade300, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordToggle() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: IconButton(
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.white.withOpacity(0.8),
              size: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassSubmitButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF9ACD32).withOpacity(0.9),
                const Color(0xFF7CB342).withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF9ACD32).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: _isLoading ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    _isLogin ? 'Sign In' : 'Create Account',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleAuth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _isLogin ? "Don't have an account? " : "Already have an account? ",
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
        GestureDetector(
          onTap: _toggleAuthMode,
          child: Text(
            _isLogin ? 'Sign Up' : 'Sign In',
            style: const TextStyle(
              color: Color(0xFF9ACD32),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFF9ACD32),
            ),
          ),
        ),
      ],
    );
  }
}
