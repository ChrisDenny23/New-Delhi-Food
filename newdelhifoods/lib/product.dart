// fixed_product_page.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'cart_manager.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CartManager cartManager = CartManager();

  // Products data
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Beetroot',
      'subtitle': 'Local shop',
      'weight': '500 gm.',
      'price': 17.0,
      'image': 'assets/images/prod1.jpg',
      'icon': Icons.eco,
    },
    {
      'name': 'Raw Sugar',
      'subtitle': 'Local shop',
      'weight': '500 gm.',
      'price': 12.0,
      'image': 'assets/images/prod2.jpg',
      'icon': Icons.local_grocery_store,
    },
    {
      'name': 'Cashew Nuts',
      'subtitle': 'Dry Fruit',
      'weight': '500 gm.',
      'price': 14.0,
      'image': 'assets/images/prod3.jpg',
      'icon': Icons.inventory_2,
    },
    {
      'name': 'Millets',
      'subtitle': 'Organic',
      'weight': '500 gm.',
      'price': 16.0,
      'image': 'assets/images/prod4.jpg',
      'icon': Icons.restaurant,
    },
    {
      'name': 'Garam Masala',
      'subtitle': 'Spices',
      'weight': '500 gm.',
      'price': 18.0,
      'image': 'assets/images/prod5.jpg',
      'icon': Icons.local_drink,
    },
    {
      'name': 'Turmeric Powder',
      'subtitle': 'Spices',
      'weight': '500 gm.',
      'price': 22.0,
      'image': 'assets/images/prod6.jpg',
      'icon': Icons.eco,
    },
    {
      'name': 'Fresh Carrots',
      'subtitle': 'Organic',
      'weight': '500 gm.',
      'price': 8.0,
      'image': 'assets/images/prod7.jpg',
      'icon': Icons.agriculture,
    },
    {
      'name': 'Cucumber',
      'subtitle': 'Fresh',
      'weight': '500 gm.',
      'price': 6.0,
      'image': 'assets/images/prod8.jpg',
      'icon': Icons.local_florist,
    },
    {
      'name': 'Raisins',
      'subtitle': 'Dry Fruits',
      'weight': '500 gm.',
      'price': 15.0,
      'image': 'assets/images/prod9.jpg',
      'icon': Icons.fastfood,
    },
    {
      'name': 'Fresh Cabbage',
      'subtitle': 'Organic',
      'weight': '500 gm.',
      'price': 9.0,
      'image': 'assets/images/prod10.jpg',
      'icon': Icons.grass,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(screenWidth),
        vertical: 40,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFFF8F8F8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Products Section
            _buildProductsSection(screenWidth),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

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
    if (screenWidth > 768) return 0.8;
    if (screenWidth > 480) return 0.75;
    return 0.7;
  }

  double _getGridSpacing(double screenWidth) {
    if (screenWidth > 768) return 20;
    if (screenWidth > 480) return 16;
    return 12;
  }

  Widget _buildProductsSection(double screenWidth) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'You might need',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: _getHeaderFontSize(screenWidth),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D1B16),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'See more',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: _getSeeMoreFontSize(screenWidth),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFB87333),
                    ),
                  ),
                  SizedBox(width: screenWidth > 480 ? 8 : 4),
                  Icon(
                    Icons.arrow_forward,
                    color: const Color(0xFFB87333),
                    size: _getArrowIconSize(screenWidth),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Products Grid
          AnimatedBuilder(
            animation: cartManager,
            builder: (context, child) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(screenWidth),
                  childAspectRatio: _getChildAspectRatio(screenWidth),
                  crossAxisSpacing: _getGridSpacing(screenWidth),
                  mainAxisSpacing: _getGridSpacing(screenWidth),
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductCard(
                    index,
                    product['name'] as String,
                    product['subtitle'] as String,
                    product['weight'] as String,
                    product['price'] as double,
                    product['image'] as String,
                    product['icon'] as IconData,
                    screenWidth,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  double _getHeaderFontSize(double screenWidth) {
    if (screenWidth > 1200) return 36;
    if (screenWidth > 768) return 32;
    if (screenWidth > 480) return 28;
    return 24;
  }

  double _getSeeMoreFontSize(double screenWidth) {
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 15;
    return 14;
  }

  double _getArrowIconSize(double screenWidth) {
    if (screenWidth > 768) return 20;
    if (screenWidth > 480) return 18;
    return 16;
  }

  Widget _buildProductCard(
    int productIndex,
    String name,
    String subtitle,
    String weight,
    double price,
    String imagePath,
    IconData fallbackIcon,
    double screenWidth,
  ) {
    final quantity = cartManager.getQuantity(productIndex);
    final isInCart = quantity > 0;
    final isMobile = screenWidth <= 480;

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
      child: Column(
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
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Icon(
                          fallbackIcon,
                          size: _getFallbackIconSize(screenWidth),
                          color: const Color(0xFF7CB342),
                        ),
                      ),
                    );
                  },
                ),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
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
                  Text(
                    weight,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: _getWeightFontSize(screenWidth),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF888888),
                    ),
                  ),
                  Text(
                    '₹${price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: _getPriceFontSize(screenWidth),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D1B16),
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
            child: isInCart
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
                          onTap: () {
                            if (quantity > 1) {
                              cartManager.updateQuantity(
                                productIndex,
                                quantity - 1,
                              );
                            } else {
                              cartManager.removeItem(productIndex);
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
                              Icons.remove,
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
                          onTap: () {
                            cartManager.updateQuantity(
                              productIndex,
                              quantity + 1,
                            );
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
                    onPressed: () {
                      cartManager.addItem(
                        id: productIndex,
                        name: name,
                        subtitle: subtitle,
                        weight: weight,
                        price: price,
                        image: imagePath,
                        icon: fallbackIcon,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF0F0F0),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: const Color(0xFF2D1B16),
                      size: _getAddButtonIconSize(screenWidth),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Helper methods for responsive sizing
  double _getFallbackIconSize(double screenWidth) {
    if (screenWidth > 768) return 40;
    if (screenWidth > 480) return 36;
    return 32;
  }

  double _getProductNameFontSize(double screenWidth) {
    if (screenWidth > 1200) return 18;
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 14;
    return 12;
  }

  double _getSubtitleFontSize(double screenWidth) {
    if (screenWidth > 768) return 12;
    if (screenWidth > 480) return 11;
    return 10;
  }

  double _getWeightFontSize(double screenWidth) {
    if (screenWidth > 768) return 12;
    if (screenWidth > 480) return 11;
    return 10;
  }

  double _getPriceFontSize(double screenWidth) {
    if (screenWidth > 1200) return 22;
    if (screenWidth > 768) return 20;
    if (screenWidth > 480) return 18;
    return 16;
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
    if (screenWidth > 768) return 18;
    if (screenWidth > 480) return 17;
    return 16;
  }

  double _getAddButtonIconSize(double screenWidth) {
    if (screenWidth > 768) return 24;
    if (screenWidth > 480) return 22;
    return 20;
  }
}
