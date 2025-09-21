// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:newdelhifoods/cart_button.dart';
import 'auth_dialog.dart'; // Import the separated authentication dialog
// Import the separated cart button

class HeaderSection extends StatefulWidget {
  final int cartItemCount;
  final VoidCallback? onCartPressed;

  const HeaderSection({super.key, this.cartItemCount = 0, this.onCartPressed});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
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
        color: const Color(0xFF043C3E),
        borderRadius: isMobile
            ? null
            : const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Menu Icon
            if (isMobile)
              IconButton(
                onPressed: () => _showMobileMenu(context),
                icon: const Icon(Icons.menu, color: Colors.white, size: 24),
              )
            else
              const SizedBox(width: 8),

            // Logo and Brand Name
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF043C3E).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'New Delhi Foods',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Search Bar (Desktop only)
            if (!isMobile) ...[
              Container(
                width: 400,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for Grocery, Stores, Vegetable or Meat',
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],

            // Quick Delivery Badge & Cart
            Row(
              children: [
                if (!isMobile) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.bolt,
                          color: Color(0xFF2D5A4A),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Order now and get it within 15 min!',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2D5A4A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],

                // Dynamic Cart Button
                CartButton(
                  itemCount: widget.cartItemCount,
                  onPressed: widget.onCartPressed,
                ),

                const SizedBox(width: 8),

                // Profile Avatar
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFF9ACD32),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAuthDialog(bool isLogin) {
    showDialog(
      context: context,
      builder: (context) => AuthDialog(isLogin: isLogin),
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
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Color(0xFF043C3E), // Match app bar color
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Close button and title
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
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Search Bar
                        const SizedBox(height: 30),
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
                                  'About',
                                  Icons.info,
                                  () {},
                                ),
                                _buildMobileMenuItem(
                                  'Contact',
                                  Icons.contact_mail,
                                  () {},
                                ),
                                const Divider(color: Colors.white24),
                                _buildMobileMenuItem(
                                  'Login',
                                  Icons.login,
                                  () => _showAuthDialog(true),
                                ),
                                _buildMobileMenuItem(
                                  'Sign Up',
                                  Icons.person_add,
                                  () => _showAuthDialog(false),
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
          ),
        );
      },
    );
  }

  Widget _buildMobileMenuItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: Colors.white, size: 20),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
      ),
    );
  }
}
