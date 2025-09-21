// updated_cart_button.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'cart_manager.dart';
import 'cart_page.dart';

class CartButton extends StatelessWidget {
  final double iconSize;
  final double badgeSize;
  final VoidCallback? customOnPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? badgeColor;
  final Color? badgeTextColor;

  const CartButton({
    super.key,
    this.iconSize = 24,
    this.badgeSize = 10,
    this.customOnPressed,
    this.backgroundColor,
    this.iconColor = Colors.white,
    this.badgeColor = const Color(0xFFFFC107),
    this.badgeTextColor = const Color(0xFF2D5A4A),
    required int itemCount,
    VoidCallback? onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final CartManager cartManager = CartManager();

    return AnimatedBuilder(
      animation: cartManager,
      builder: (context, child) {
        return GestureDetector(
          onTap:
              customOnPressed ??
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: iconColor,
                  size: iconSize,
                ),
                if (cartManager.itemCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        cartManager.itemCount > 99
                            ? '99+'
                            : cartManager.itemCount.toString(),
                        style: TextStyle(
                          fontSize: badgeSize,
                          fontWeight: FontWeight.w600,
                          color: badgeTextColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
