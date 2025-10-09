// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'cart_manager.dart';
import 'all_products_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CartManager cartManager = CartManager();

  // Sample products data with string IDs (simulating UUIDs)
  final List<Map<String, dynamic>> products = [
    {
      'id': 'product-1-almonds',
      'name': 'Almonds',
      'subtitle': 'Local shop',
      'weight': '500 gm.',
      'image': 'assets/images/prod1.jpg',
      'icon': Icons.eco,
    },
    {
      'id': 'product-2-raw-sugar',
      'name': 'Raw Sugar',
      'subtitle': 'Local shop',
      'weight': '500 gm.',
      'image': 'assets/images/prod2.jpg',
      'icon': Icons.local_grocery_store,
    },
    {
      'id': 'product-3-cashew-nuts',
      'name': 'Cashew Nuts',
      'subtitle': 'Dry Fruit',
      'weight': '500 gm.',
      'image': 'assets/images/prod3.jpg',
      'icon': Icons.inventory_2,
    },
    {
      'id': 'product-4-millets',
      'name': 'Millets',
      'subtitle': 'Organic',
      'weight': '500 gm.',
      'image': 'assets/images/prod4.jpg',
      'icon': Icons.restaurant,
    },
    {
      'id': 'product-5-garam-masala',
      'name': 'Garam Masala',
      'subtitle': 'Spices',
      'weight': '500 gm.',
      'image': 'assets/images/prod5.jpg',
      'icon': Icons.local_drink,
    },
    {
      'id': 'product-6-turmeric-powder',
      'name': 'Turmeric Powder',
      'subtitle': 'Spices',
      'weight': '500 gm.',
      'image': 'assets/images/prod6.jpg',
      'icon': Icons.eco,
    },
    {
      'id': 'product-7-pistachios',
      'name': 'Pistachios',
      'subtitle': 'Dry Fruits',
      'weight': '500 gm.',
      'image': 'assets/images/prod7.jpg',
      'icon': Icons.agriculture,
    },
    {
      'id': 'product-8-brown-rice',
      'name': 'Brown Rice',
      'subtitle': 'Grains',
      'weight': '500 gm.',
      'image': 'assets/images/prod8.jpg',
      'icon': Icons.local_florist,
    },
    {
      'id': 'product-9-raisins',
      'name': 'Raisins',
      'subtitle': 'Dry Fruits',
      'weight': '500 gm.',
      'image': 'assets/images/prod9.jpg',
      'icon': Icons.fastfood,
    },
    {
      'id': 'product-10-chickpeas',
      'name': 'Chickpeas',
      'subtitle': 'Pulses',
      'weight': '500 gm.',
      'image': 'assets/images/prod10.jpg',
      'icon': Icons.grass,
    },
  ];

  // Gift packs data
  final List<Map<String, dynamic>> giftPacks = [
    {
      'name': 'Small Gift Pack',
      'subtitle': 'Perfect for trying',
      'weight': '500g - 1kg',
      'contents': '2-3 Spices • 1-2 Grains • 1-2 Millets • 1-2 Pulses',
      'priceRange': '₹500 - ₹1,000',
      'image': 'assets/images/gift_small.jpg',
      'icon': Icons.card_giftcard,
      'color': Color(0xFF7CB342),
    },
    {
      'name': 'Medium Gift Pack',
      'subtitle': 'Great for families',
      'weight': '1kg - 2kg',
      'contents': '4-5 Spices • 2-3 Grains • 2-3 Millets • 2-3 Pulses',
      'priceRange': '₹1,000 - ₹2,500',
      'image': 'assets/images/gift_medium.jpg',
      'icon': Icons.redeem,
      'color': Color(0xFFB87333),
    },
    {
      'name': 'Large Gift Pack',
      'subtitle': 'Premium collection',
      'weight': '2kg - 5kg',
      'contents': '6-7 Spices • 3-4 Grains • 3-4 Millets • 3-4 Pulses',
      'priceRange': '₹2,500 - ₹5,000',
      'image': 'assets/images/gift_large.jpg',
      'icon': Icons.local_grocery_store,
      'color': Color(0xFFD4522A),
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
            const SizedBox(height: 60),

            // Gift Section
            _buildGiftSection(screenWidth),
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
    if (screenWidth > 768) return 0.85;
    if (screenWidth > 480) return 0.8;
    return 0.75;
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
              // Updated "See more" button with navigation
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllProductsPage(),
                    ),
                  );
                },
                child: Row(
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
                    product['id'] as String, // Using string ID
                    product['name'] as String,
                    product['subtitle'] as String,
                    product['weight'] as String,
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

  Widget _buildGiftSection(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_getHorizontalPadding(screenWidth) * 0.8),
      decoration: BoxDecoration(
        color: Color(0xFF2D5A4A),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF2D5A4A).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Gift Section Header
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth > 480 ? 20 : 16,
                  vertical: screenWidth > 480 ? 12 : 10,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFD4522A),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.card_giftcard,
                      color: Colors.white,
                      size: screenWidth > 480 ? 24 : 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Taste of India',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: screenWidth > 480 ? 18 : 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenWidth > 480 ? 16 : 12),
              Text(
                'Experience the richness of Indian cuisine with our carefully curated gift pack',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: _getSubHeaderFontSize(screenWidth),
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: screenWidth > 480 ? 30 : 24),

          // Gift Packs Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth > 900
                  ? 3
                  : (screenWidth > 600 ? 2 : 1),
              childAspectRatio: screenWidth > 900
                  ? 0.85
                  : (screenWidth > 600 ? 0.9 : 1.1),
              crossAxisSpacing: _getGridSpacing(screenWidth),
              mainAxisSpacing: _getGridSpacing(screenWidth),
            ),
            itemCount: giftPacks.length,
            itemBuilder: (context, index) {
              final pack = giftPacks[index];
              return _buildGiftPackCard(pack, screenWidth);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGiftPackCard(Map<String, dynamic> pack, double screenWidth) {
    final isMobile = screenWidth <= 480;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: (pack['color'] as Color).withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Gift Pack Image/Icon
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(isMobile ? 16 : 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/gift.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            (pack['color'] as Color).withOpacity(0.1),
                            (pack['color'] as Color).withOpacity(0.2),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Icon(
                          pack['icon'] as IconData,
                          size: screenWidth > 768
                              ? 60
                              : (screenWidth > 480 ? 50 : 40),
                          color: pack['color'] as Color,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Gift Pack Info
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pack['name'] as String,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: _getGiftNameFontSize(screenWidth),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D1B16),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    pack['subtitle'] as String,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: _getGiftSubtitleFontSize(screenWidth),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF666666),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: (pack['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      pack['weight'] as String,
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: _getGiftWeightFontSize(screenWidth),
                        fontWeight: FontWeight.w600,
                        color: pack['color'] as Color,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    pack['contents'] as String,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: _getGiftContentsFontSize(screenWidth),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF888888),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Text(
                    pack['priceRange'] as String,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: _getGiftPriceFontSize(screenWidth),
                      fontWeight: FontWeight.w700,
                      color: pack['color'] as Color,
                    ),
                  ),
                  SizedBox(height: 12),
                  // Contact for more info
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB87333).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Contact for more info',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: _getGiftContactTextSize(screenWidth),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFB87333),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    String productId, // Changed to String
    String name,
    String subtitle,
    String weight,
    String imagePath,
    IconData fallbackIcon,
    double screenWidth,
  ) {
    final quantity = cartManager.getQuantity(productId);
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
                  // Contact info instead of price
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                                productId,
                                quantity - 1,
                              );
                            } else {
                              cartManager.removeItem(productId);
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
                            cartManager.updateQuantity(productId, quantity + 1);
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
                        id: productId, // Using string ID
                        name: name,
                        subtitle: subtitle,
                        weight: weight,
                        price: 0.0, // Price set to 0 for contact pricing
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
  double _getHeaderFontSize(double screenWidth) {
    if (screenWidth > 1200) return 36;
    if (screenWidth > 768) return 32;
    if (screenWidth > 480) return 28;
    return 24;
  }

  double _getSubHeaderFontSize(double screenWidth) {
    if (screenWidth > 768) return 18;
    if (screenWidth > 480) return 16;
    return 14;
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

  double _getContactTextSize(double screenWidth) {
    if (screenWidth > 768) return 12;
    if (screenWidth > 480) return 11;
    return 10;
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

  // Gift pack sizing methods
  double _getGiftNameFontSize(double screenWidth) {
    if (screenWidth > 768) return 20;
    if (screenWidth > 480) return 18;
    return 16;
  }

  double _getGiftSubtitleFontSize(double screenWidth) {
    if (screenWidth > 768) return 14;
    if (screenWidth > 480) return 13;
    return 12;
  }

  double _getGiftWeightFontSize(double screenWidth) {
    if (screenWidth > 768) return 12;
    if (screenWidth > 480) return 11;
    return 10;
  }

  double _getGiftContentsFontSize(double screenWidth) {
    if (screenWidth > 768) return 11;
    if (screenWidth > 480) return 10;
    return 9;
  }

  double _getGiftPriceFontSize(double screenWidth) {
    if (screenWidth > 768) return 18;
    if (screenWidth > 480) return 16;
    return 14;
  }

  double _getGiftContactTextSize(double screenWidth) {
    if (screenWidth > 768) return 11;
    if (screenWidth > 480) return 10;
    return 9;
  }
}
