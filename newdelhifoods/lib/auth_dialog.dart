// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AuthDialog extends StatefulWidget {
  final bool isLogin;

  const AuthDialog({super.key, required this.isLogin});

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Handle authentication logic here
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isLogin
                ? 'Login successful!'
                : 'Account created successfully!',
          ),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                constraints: BoxConstraints(maxWidth: 400, maxHeight: 600),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2D1B16), Color(0xFF3D2B26)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(128),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Text(
                          widget.isLogin ? 'Welcome Back!' : 'Create Account',
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.isLogin
                              ? 'Sign in to your account'
                              : 'Join New Delhi Foods today',
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: 16,
                            color: Colors.white.withAlpha(179),
                          ),
                        ),
                        SizedBox(height: 30),

                        // Name field (only for sign up)
                        if (!widget.isLogin) ...[
                          _buildTextField(
                            controller: _nameController,
                            label: 'Full Name',
                            icon: Icons.person,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                        ],

                        // Email field
                        _buildTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        // Password field
                        _buildTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock,
                          isPassword: true,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your password';
                            }
                            if (!widget.isLogin && value!.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 30),

                        // Submit button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleSubmit,
                            style:
                                ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ).copyWith(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFFC107),
                                    Color(0xFFFFB300),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                alignment: Alignment.center,
                                child: Text(
                                  widget.isLogin ? 'Sign In' : 'Create Account',
                                  style: TextStyle(
                                    fontFamily: 'Josefin Sans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2D1B16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Switch between login/signup
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  AuthDialog(isLogin: !widget.isLogin),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: 16,
                                color: Colors.white.withAlpha(179),
                              ),
                              children: [
                                TextSpan(
                                  text: widget.isLogin
                                      ? "Don't have an account? "
                                      : "Already have an account? ",
                                ),
                                TextSpan(
                                  text: widget.isLogin ? 'Sign Up' : 'Sign In',
                                  style: TextStyle(
                                    color: Color(0xFFFFC107),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withAlpha(179)),
        prefixIcon: Icon(icon, color: Colors.white.withAlpha(179)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white.withAlpha(179),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white.withAlpha(26),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withAlpha(51)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withAlpha(51)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFFFC107), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
