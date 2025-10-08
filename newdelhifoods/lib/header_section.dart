// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:newdelhifoods/cart_button.dart';
import 'auth_popup.dart'; // Import the new auth popup

class HeaderSection extends StatefulWidget {
  final int cartItemCount;
  final VoidCallback? onCartPressed;

  const HeaderSection({super.key, this.cartItemCount = 0, this.onCartPressed});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  bool _isLoggedIn = false;
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final token = await _storage.read(key: 'access_token');
    setState(() {
      _isLoggedIn = token != null && token.isNotEmpty;
    });
  }

  Future<void> _logout() async {
    await _storage.delete(key: 'access_token');
    setState(() {
      _isLoggedIn = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Logged out successfully'),
        backgroundColor: const Color(0xFF9ACD32),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: screenWidth,
      height: 100,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF043C3E), Color(0xFF065A5D)],
        ),
        borderRadius: isMobile
            ? null
            : const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Menu Icon for Mobile
            if (isMobile)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () => _showMobileMenu(context),
                  icon: const Icon(Icons.menu, color: Colors.white, size: 24),
                ),
              )
            else
              const SizedBox(width: 8),

            // Enhanced Logo and Brand Name
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9ACD32), Color(0xFF7CB342)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.storefront,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New Delhi Foods',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Fresh & Fast Delivery',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: isMobile ? 10 : 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.8),
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            // Enhanced Search Bar (Desktop only)
            if (!isMobile) ...[
              Container(
                width: 450,
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for Grocery, Stores, Vegetable or Meat',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.search,
                        color: Color(0xFF043C3E),
                        size: 20,
                      ),
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF9ACD32), Color(0xFF7CB342)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color(0xFF9ACD32),
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],

            // Action Buttons Section
            Row(
              children: [
                // Quick Delivery Badge (Desktop only)
                if (!isMobile) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFC107), Color(0xFFFFB300)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.flash_on,
                          color: Color(0xFF2D5A4A),
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Order now - 15 min delivery!',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2D5A4A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                ],

                // Cart Button
                CartButton(
                  itemCount: widget.cartItemCount,
                  onPressed: widget.onCartPressed,
                ),

                const SizedBox(width: 16),

                // Login & Signup Buttons
                if (!isMobile) ...[
                  if (!_isLoggedIn) ...[
                    // Login Button
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await AuthPopup.showAuthModal(context, isLogin: true);
                          await _checkLoginStatus();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Signup Button
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF9ACD32), Color(0xFF7CB342)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF9ACD32).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await AuthPopup.showAuthModal(
                            context,
                            isLogin: false,
                          );
                          await _checkLoginStatus();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.person_add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF9ACD32), Color(0xFF7CB342)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF9ACD32).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'logout') {
                            await _logout();
                          } else if (value == 'account') {
                            // TODO: Navigate to account page
                          } else if (value == 'orders') {
                            // TODO: Navigate to orders page
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'account',
                            child: Text('My Account'),
                          ),
                          const PopupMenuItem(
                            value: 'orders',
                            child: Text('My Orders'),
                          ),
                          const PopupMenuItem(
                            value: 'logout',
                            child: Text('Logout'),
                          ),
                        ],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Account',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ] else ...[
                  // Mobile Auth Button
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF9ACD32), Color(0xFF7CB342)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _isLoggedIn
                        ? PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value == 'logout') {
                                await _logout();
                              } else if (value == 'account') {
                                // TODO: Navigate to account page
                              } else if (value == 'orders') {
                                // TODO: Navigate to orders page
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'account',
                                child: Text('My Account'),
                              ),
                              const PopupMenuItem(
                                value: 'orders',
                                child: Text('My Orders'),
                              ),
                              const PopupMenuItem(
                                value: 'logout',
                                child: Text('Logout'),
                              ),
                            ],
                            icon: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              await AuthPopup.showAuthModal(
                                context,
                                isLogin: true,
                              );
                              await _checkLoginStatus();
                            },
                            icon: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position:
              Tween(
                begin: const Offset(-1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(
                CurvedAnimation(parent: animation1, curve: Curves.easeInOut),
              ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Material(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF043C3E), Color(0xFF065A5D)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Menu',
                              style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Mobile Search
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search products...',
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xFF043C3E),
                                size: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Menu Items
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildMobileMenuItem('Home', Icons.home, () {}),
                                _buildMobileMenuItem(
                                  'Categories',
                                  Icons.category,
                                  () {},
                                ),
                                _buildMobileMenuItem(
                                  'Offers',
                                  Icons.local_offer,
                                  () {},
                                ),
                                _buildMobileMenuItem(
                                  'About',
                                  Icons.info_outline,
                                  () {},
                                ),
                                _buildMobileMenuItem(
                                  'Contact',
                                  Icons.contact_support,
                                  () {},
                                ),

                                const SizedBox(height: 20),
                                const Divider(color: Colors.white24),
                                const SizedBox(height: 20),

                                // Auth Buttons for Mobile
                                if (!_isLoggedIn) ...[
                                  _buildMobileMenuItem(
                                    'Login',
                                    Icons.login,
                                    () async {
                                      Navigator.pop(context);
                                      await AuthPopup.showAuthModal(
                                        context,
                                        isLogin: true,
                                      );
                                      await _checkLoginStatus();
                                    },
                                  ),
                                  _buildMobileMenuItem(
                                    'Sign Up',
                                    Icons.person_add,
                                    () async {
                                      Navigator.pop(context);
                                      await AuthPopup.showAuthModal(
                                        context,
                                        isLogin: false,
                                      );
                                      await _checkLoginStatus();
                                    },
                                  ),
                                ] else ...[
                                  _buildMobileMenuItem(
                                    'My Account',
                                    Icons.account_circle,
                                    () {
                                      Navigator.pop(context);
                                      // TODO: Navigate to account page
                                    },
                                  ),
                                  _buildMobileMenuItem(
                                    'My Orders',
                                    Icons.shopping_bag,
                                    () {
                                      Navigator.pop(context);
                                      // TODO: Navigate to orders page
                                    },
                                  ),
                                  _buildMobileMenuItem(
                                    'Logout',
                                    Icons.logout,
                                    () async {
                                      await _logout();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
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
          ),
        );
      },
    );
  }

  Widget _buildMobileMenuItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        dense: true,
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF9ACD32).withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF9ACD32), size: 18),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 14,
        ),
        onTap: onTap,
      ),
    );
  }
}
