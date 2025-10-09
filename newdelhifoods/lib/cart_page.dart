// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:newdelhifoods/config.dart';
import 'cart_manager.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartManager cartManager = CartManager();
  final _storage = const FlutterSecureStorage();
  final Dio _dio = Dio();
  bool _isPlacingOrder = false;

  @override
  void initState() {
    super.initState();
    cartManager.initialize(); // Initialize cart manager
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF043C3E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        shape: isMobile
            ? null
            : const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AnimatedBuilder(
          animation: cartManager,
          builder: (context, child) {
            if (cartManager.items.isEmpty) {
              return _buildEmptyCart(screenWidth);
            }

            return Column(
              children: [
                // Cart header with item count
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: _getHorizontalPadding(screenWidth),
                    right: _getHorizontalPadding(screenWidth),
                    top: 8,
                    bottom: 8,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF043C3E), Color(0xFF055A5C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF043C3E).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${cartManager.itemCount} ${cartManager.itemCount == 1 ? 'Item' : 'Items'} in Cart',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: _getSummaryTextSize(screenWidth),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
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
                              color: Color(0xFF043C3E),
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Fast Delivery',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF043C3E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: _getHorizontalPadding(screenWidth),
                      right: _getHorizontalPadding(screenWidth),
                      top: 4,
                      bottom: 8,
                    ),
                    itemCount: cartManager.items.length,
                    itemBuilder: (context, index) {
                      final item = cartManager.items[index];
                      return _buildCartItem(item, screenWidth);
                    },
                  ),
                ),
                _buildBottomSection(screenWidth),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyCart(double screenWidth) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(_getHorizontalPadding(screenWidth)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFF043C3E).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: _getEmptyCartIconSize(screenWidth),
                color: const Color(0xFF043C3E),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: _getEmptyCartTitleSize(screenWidth),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D1B16),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Add some delicious items from our store\nto get started with your order',
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: _getEmptyCartSubtitleSize(screenWidth),
                fontWeight: FontWeight.w400,
                color: const Color(0xFF666666),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF043C3E), Color(0xFF055A5C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF043C3E).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 480 ? 40 : 32,
                    vertical: screenWidth > 480 ? 16 : 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Continue Shopping',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: _getButtonTextSize(screenWidth),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(CartItem item, double screenWidth) {
    final isMobile = screenWidth <= 480;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF043C3E).withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Row(
          children: [
            // Product Image
            Container(
              width: _getCartImageSize(screenWidth),
              height: _getCartImageSize(screenWidth),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFF8F9FA),
                border: Border.all(
                  color: const Color(0xFF043C3E).withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: item.image.startsWith('http')
                    ? Image.network(
                        item.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              item.icon,
                              size: _getCartFallbackIconSize(screenWidth),
                              color: const Color(0xFF043C3E),
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        item.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              item.icon,
                              size: _getCartFallbackIconSize(screenWidth),
                              color: const Color(0xFF043C3E),
                            ),
                          );
                        },
                      ),
              ),
            ),

            SizedBox(width: isMobile ? 16 : 20),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: _getCartProductNameSize(screenWidth),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2D1B16),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${item.subtitle} • ${item.weight}',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: _getCartSubtitleSize(screenWidth),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF666666),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (item.price > 0) ...[
                        Text(
                          '₹${item.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: _getCartPriceSize(screenWidth),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF043C3E),
                          ),
                        ),
                        if (item.quantity > 1) ...[
                          const SizedBox(width: 8),
                          Text(
                            'x${item.quantity}',
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: _getCartSubtitleSize(screenWidth),
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF666666),
                            ),
                          ),
                        ],
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB87333).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Contact for price',
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: _getCartSubtitleSize(screenWidth),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFB87333),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Quantity Controls
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF043C3E), Color(0xFF055A5C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF043C3E).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Decrease button
                  GestureDetector(
                    onTap: () {
                      if (item.quantity > 1) {
                        cartManager.updateQuantity(item.id, item.quantity - 1);
                      } else {
                        cartManager.removeItem(item.id);
                      }
                    },
                    child: Container(
                      width: _getQuantityButtonSize(screenWidth),
                      height: _getQuantityButtonSize(screenWidth),
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item.quantity > 1 ? Icons.remove : Icons.delete_outline,
                        color: Colors.white,
                        size: _getQuantityIconSize(screenWidth),
                      ),
                    ),
                  ),
                  // Quantity
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth > 480 ? 16 : 12,
                    ),
                    child: Text(
                      item.quantity.toString(),
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: _getQuantityTextSize(screenWidth),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Increase button
                  GestureDetector(
                    onTap: () {
                      cartManager.updateQuantity(item.id, item.quantity + 1);
                    },
                    child: Container(
                      width: _getQuantityButtonSize(screenWidth),
                      height: _getQuantityButtonSize(screenWidth),
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: _getQuantityIconSize(screenWidth),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection(double screenWidth) {
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(screenWidth),
        vertical: isMobile ? 16 : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF043C3E).withOpacity(0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Order Summary
          Container(
            padding: EdgeInsets.all(isMobile ? 12 : 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF043C3E).withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Items (${cartManager.itemCount})',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: _getCompactSummaryTextSize(screenWidth),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF666666),
                      ),
                    ),
                    Text(
                      cartManager.totalAmount > 0
                          ? '₹${cartManager.totalAmount.toStringAsFixed(0)}'
                          : 'Contact for price',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: _getCompactSummaryTextSize(screenWidth),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2D1B16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.bolt,
                          color: Color(0xFFFFC107),
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Delivery',
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: _getCompactSummaryTextSize(screenWidth),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF043C3E).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Free',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: _getCompactSummaryTextSize(screenWidth) - 1,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF043C3E),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFF043C3E).withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: _getCompactTotalTextSize(screenWidth),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2D1B16),
                      ),
                    ),
                    Text(
                      cartManager.totalAmount > 0
                          ? '₹${cartManager.totalAmount.toStringAsFixed(0)}'
                          : 'Contact for price',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: _getCompactTotalTextSize(screenWidth),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF043C3E),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),

          // Checkout Button
          Container(
            width: double.infinity,
            height: _getCompactCheckoutButtonHeight(screenWidth),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF043C3E), Color(0xFF055A5C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF043C3E).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _isPlacingOrder ? null : _placeOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: _isPlacingOrder
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Place Order',
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: _getCompactButtonTextSize(screenWidth),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _placeOrder() async {
    setState(() {
      _isPlacingOrder = true;
    });

    try {
      // Get access token from storage
      final accessToken = await _storage.read(key: 'access_token');

      if (accessToken == null || accessToken.isEmpty) {
        _showErrorMessage('Please login to place an order');
        return;
      }

      // Make API call to place order with authentication header
      final response = await _dio.post(
        '$apiBaseUrl/orders/add-order',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        _showOrderSuccessDialog(
          response.data['orderId'],
          response.data['totalAmount'],
        );
      } else {
        _showErrorMessage(response.data['error'] ?? 'Failed to place order');
      }
    } on DioException catch (e) {
      String errorMessage = 'Network error. Please try again.';

      if (e.response?.data != null && e.response?.data['error'] != null) {
        errorMessage = e.response?.data['error'];
      } else if (e.response?.statusCode == 401) {
        errorMessage = 'Please login to continue';
      }

      _showErrorMessage(errorMessage);
    } catch (e) {
      _showErrorMessage('An unexpected error occurred');
    } finally {
      if (mounted) {
        setState(() {
          _isPlacingOrder = false;
        });
      }
    }
  }

  void _showOrderSuccessDialog(String orderId, double totalAmount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF7CB342).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Color(0xFF7CB342),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Order Placed!',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D1B16),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your order has been successfully placed!',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID: ${orderId.substring(0, 8)}...',
                      style: const TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xFF043C3E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total: ₹${totalAmount.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF2D1B16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'You will receive your items within 15 minutes. Thank you for shopping with New Delhi Foods!',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
              ),
            ],
          ),
          actions: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF043C3E), Color(0xFF055A5C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  cartManager.clearCart(); // Clear cart
                  Navigator.pop(context); // Go back to previous page
                },
                child: const Text(
                  'Continue Shopping',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Responsive sizing methods
  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth > 1200) return 80;
    if (screenWidth > 768) return 60;
    if (screenWidth > 480) return 30;
    return 20;
  }

  double _getEmptyCartIconSize(double screenWidth) {
    if (screenWidth > 768) return 100;
    if (screenWidth > 480) return 80;
    return 64;
  }

  double _getEmptyCartTitleSize(double screenWidth) {
    if (screenWidth > 768) return 28;
    if (screenWidth > 480) return 24;
    return 20;
  }

  double _getEmptyCartSubtitleSize(double screenWidth) {
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 15;
    return 14;
  }

  double _getCartImageSize(double screenWidth) {
    if (screenWidth > 768) return 85;
    if (screenWidth > 480) return 75;
    return 65;
  }

  double _getCartFallbackIconSize(double screenWidth) {
    if (screenWidth > 768) return 42;
    if (screenWidth > 480) return 38;
    return 32;
  }

  double _getCartProductNameSize(double screenWidth) {
    if (screenWidth > 768) return 18;
    if (screenWidth > 480) return 16;
    return 15;
  }

  double _getCartSubtitleSize(double screenWidth) {
    if (screenWidth > 768) return 14;
    if (screenWidth > 480) return 13;
    return 12;
  }

  double _getCartPriceSize(double screenWidth) {
    if (screenWidth > 768) return 20;
    if (screenWidth > 480) return 18;
    return 16;
  }

  double _getQuantityButtonSize(double screenWidth) {
    if (screenWidth > 768) return 36;
    if (screenWidth > 480) return 32;
    return 28;
  }

  double _getQuantityIconSize(double screenWidth) {
    if (screenWidth > 768) return 18;
    if (screenWidth > 480) return 16;
    return 14;
  }

  double _getQuantityTextSize(double screenWidth) {
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 15;
    return 14;
  }

  double _getSummaryTextSize(double screenWidth) {
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 15;
    return 14;
  }

  double _getButtonTextSize(double screenWidth) {
    if (screenWidth > 768) return 18;
    if (screenWidth > 480) return 16;
    return 15;
  }

  double _getCompactSummaryTextSize(double screenWidth) {
    if (screenWidth > 768) return 14;
    if (screenWidth > 480) return 13;
    return 12;
  }

  double _getCompactTotalTextSize(double screenWidth) {
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 15;
    return 14;
  }

  double _getCompactCheckoutButtonHeight(double screenWidth) {
    if (screenWidth > 768) return 48;
    if (screenWidth > 480) return 44;
    return 40;
  }

  double _getCompactButtonTextSize(double screenWidth) {
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 15;
    return 14;
  }
}
