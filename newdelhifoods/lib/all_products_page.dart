// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:newdelhifoods/config.dart';
import 'cart_manager.dart';
import 'cart_page.dart';
import 'cart_button.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  final CartManager cartManager = CartManager();
  final Dio _dio = Dio();
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchAllProducts();
    cartManager.initialize(); // Initialize cart manager
  }

  Future<void> _fetchAllProducts() async {
    try {
      setState(() {
        isLoading = true;
        hasError = false;
      });

      final response = await _dio.get('$apiBaseUrl/products/getallproducts');

      if (response.statusCode == 200 && response.data['success'] == true) {
        setState(() {
          products = List<Map<String, dynamic>>.from(response.data['products']);
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          errorMessage = response.data['error'] ?? 'Failed to fetch products';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = 'Network error: $e';
        isLoading = false;
      });
    }
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
          'All Products',
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
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CartButton(), // Using the CartButton component
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _buildBody(screenWidth),
      ),
    );
  }

  Widget _buildBody(double screenWidth) {
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF043C3E)),
            ),
            SizedBox(height: 16),
            Text(
              'Loading products...',
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 16,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
      );
    }

    if (hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D1B16),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                errorMessage,
                style: const TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 14,
                  color: Color(0xFF666666),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _fetchAllProducts,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF043C3E),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Retry',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (products.isEmpty) {
      return const Center(
        child: Text(
          'No products available',
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 18,
            color: Color(0xFF666666),
          ),
        ),
      );
    }

    return AnimatedBuilder(
      animation: cartManager,
      builder: (context, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _getHorizontalPadding(screenWidth),
            vertical: 20,
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(screenWidth),
              childAspectRatio: _getChildAspectRatio(screenWidth),
              crossAxisSpacing: _getGridSpacing(screenWidth),
              mainAxisSpacing: _getGridSpacing(screenWidth),
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(product, screenWidth);
            },
          ),
        );
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, double screenWidth) {
    // Get product ID as string (UUID from database)
    final String productId = product['id']?.toString() ?? '';
    final String name = product['name'] ?? 'Unknown Product';
    final String category = product['category'] ?? 'General';

    // Safely handle price conversion from database numeric type
    double price = 0.0;
    if (product['price'] != null) {
      if (product['price'] is String) {
        price = double.tryParse(product['price']) ?? 0.0;
      } else if (product['price'] is num) {
        price = product['price'].toDouble();
      }
    }

    final String imageUrl = product['image_url'] ?? '';
    final String description = product['description'] ?? '';

    // Safely handle stock conversion from database integer type
    int stock = 0;
    if (product['stock'] != null) {
      if (product['stock'] is String) {
        stock = int.tryParse(product['stock']) ?? 0;
      } else if (product['stock'] is num) {
        stock = product['stock'].toInt();
      }
    }

    final quantity = cartManager.getQuantity(productId);
    final isInCart = quantity > 0;
    final isMobile = screenWidth <= 480;
    final isOutOfStock = stock <= 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(isMobile ? 12 : 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildFallbackImage(screenWidth);
                            },
                          )
                        : _buildFallbackImage(screenWidth),
                  ),
                ),
              ),

              // Product Info
              Expanded(
                flex: screenWidth <= 480 ? 3 : 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: _getProductNameFontSize(screenWidth),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2D1B16),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        category,
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: _getSubtitleFontSize(screenWidth),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF666666),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (price > 0)
                        Text(
                          '₹${price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: _getPriceFontSize(screenWidth),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF043C3E),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB87333).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Contact for price',
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: _getContactTextSize(screenWidth),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFB87333),
                            ),
                          ),
                        ),
                      Text(
                        'Stock: $stock',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: _getStockFontSize(screenWidth),
                          fontWeight: FontWeight.w500,
                          color: stock > 0
                              ? const Color(0xFF7CB342)
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Add Button / Quantity Controls
              Container(
                width: double.infinity,
                height: _getButtonHeight(screenWidth),
                margin: EdgeInsets.fromLTRB(
                  isMobile ? 8 : 16,
                  0,
                  isMobile ? 8 : 16,
                  isMobile ? 8 : 16,
                ),
                child: isOutOfStock
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Out of Stock',
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    : isInCart
                    ? Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF7CB342),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Decrease button
                            GestureDetector(
                              onTap: () async {
                                if (quantity > 1) {
                                  await cartManager.updateQuantity(
                                    productId,
                                    quantity - 1,
                                  );
                                } else {
                                  await cartManager.removeItem(productId);
                                }
                              },
                              child: Container(
                                width: _getQuantityButtonSize(screenWidth),
                                height: _getQuantityButtonSize(screenWidth),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6DA23A),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  quantity > 1
                                      ? Icons.remove
                                      : Icons.delete_outline,
                                  color: Colors.white,
                                  size: _getQuantityIconSize(screenWidth),
                                ),
                              ),
                            ),
                            // Quantity
                            Text(
                              quantity.toString(),
                              style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: _getQuantityTextSize(screenWidth),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            // Increase button
                            GestureDetector(
                              onTap: () async {
                                if (quantity < stock) {
                                  await cartManager.updateQuantity(
                                    productId,
                                    quantity + 1,
                                  );
                                } else {
                                  _showStockLimitMessage();
                                }
                              },
                              child: Container(
                                width: _getQuantityButtonSize(screenWidth),
                                height: _getQuantityButtonSize(screenWidth),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6DA23A),
                                  borderRadius: BorderRadius.circular(20),
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
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          await cartManager.addItem(
                            id: productId, // Using string UUID
                            name: name,
                            subtitle: category,
                            weight:
                                '500g', // Default weight since not in database
                            price: price,
                            image: imageUrl,
                            icon: Icons.inventory_2,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF043C3E),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                              size: _getAddButtonIconSize(screenWidth),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Add to Cart',
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

          // Stock indicator overlay
          if (isOutOfStock)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFallbackImage(double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Icon(
          Icons.inventory_2,
          size: _getFallbackIconSize(screenWidth),
          color: const Color(0xFF7CB342),
        ),
      ),
    );
  }

  void _showStockLimitMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cannot add more items. Stock limit reached.'),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
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

  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth > 1200) return 5;
    if (screenWidth > 900) return 4;
    if (screenWidth > 600) return 3;
    return 2;
  }

  double _getChildAspectRatio(double screenWidth) {
    if (screenWidth > 768) return 0.75;
    if (screenWidth > 480) return 0.7;
    return 0.65;
  }

  double _getGridSpacing(double screenWidth) {
    if (screenWidth > 768) return 20;
    if (screenWidth > 480) return 16;
    return 12;
  }

  double _getFallbackIconSize(double screenWidth) {
    if (screenWidth > 768) return 40;
    if (screenWidth > 480) return 36;
    return 32;
  }

  double _getProductNameFontSize(double screenWidth) {
    if (screenWidth > 1200) return 16;
    if (screenWidth > 768) return 15;
    if (screenWidth > 480) return 14;
    return 12;
  }

  double _getSubtitleFontSize(double screenWidth) {
    if (screenWidth > 768) return 12;
    if (screenWidth > 480) return 11;
    return 10;
  }

  double _getPriceFontSize(double screenWidth) {
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 15;
    return 14;
  }

  double _getContactTextSize(double screenWidth) {
    if (screenWidth > 768) return 11;
    if (screenWidth > 480) return 10;
    return 9;
  }

  double _getStockFontSize(double screenWidth) {
    if (screenWidth > 768) return 11;
    if (screenWidth > 480) return 10;
    return 9;
  }

  double _getButtonHeight(double screenWidth) {
    if (screenWidth > 768) return 45;
    if (screenWidth > 480) return 40;
    return 36;
  }

  double _getQuantityButtonSize(double screenWidth) {
    if (screenWidth > 768) return 35;
    if (screenWidth > 480) return 30;
    return 26;
  }

  double _getQuantityIconSize(double screenWidth) {
    if (screenWidth > 768) return 20;
    if (screenWidth > 480) return 18;
    return 16;
  }

  double _getQuantityTextSize(double screenWidth) {
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 15;
    return 14;
  }

  double _getAddButtonIconSize(double screenWidth) {
    if (screenWidth > 768) return 20;
    if (screenWidth > 480) return 18;
    return 16;
  }

  double _getButtonTextSize(double screenWidth) {
    if (screenWidth > 768) return 14;
    if (screenWidth > 480) return 13;
    return 12;
  }
}
