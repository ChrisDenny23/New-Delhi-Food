// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final IconData icon;
  final String description;
  final double price;
  final String category;
  final List<String> images;
  final int stockCount;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
    required this.price,
    required this.category,
    required this.images,
    required this.stockCount,
    required this.rating,
    required this.reviewCount,
  });
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String selectedCategory = 'All';
  List<String> categories = [
    'All',
    'Grains',
    'Spices',
    'Pulses',
    'Oils',
    'Snacks',
    'Vegetables',
  ];

  final List<Product> products = [
    Product(
      id: '1',
      title: 'Organic Basmati Rice',
      icon: Icons.grain,
      description: 'Premium aged basmati rice with authentic aroma',
      price: 299.99,
      category: 'Grains',
      images: ['assets/images/products/prod1.jpg'],
      stockCount: 45,
      rating: 4.8,
      reviewCount: 127,
    ),
    Product(
      id: '2',
      title: 'Pure Garam Masala',
      icon: Icons.spa,
      description: 'Hand-ground blend of 12 aromatic spices',
      price: 149.99,
      category: 'Spices',
      images: ['assets/images/products/prod2.jpg'],
      stockCount: 78,
      rating: 4.9,
      reviewCount: 89,
    ),
    Product(
      id: '3',
      title: 'Organic Red Lentils',
      icon: Icons.eco,
      description: 'High-protein red lentils from organic farms',
      price: 89.99,
      category: 'Pulses',
      images: ['assets/images/products/prod3.jpg'],
      stockCount: 156,
      rating: 4.7,
      reviewCount: 203,
    ),
    Product(
      id: '4',
      title: 'Cold-Pressed Coconut Oil',
      icon: Icons.water_drop,
      description: 'Pure virgin coconut oil, cold-pressed',
      price: 399.99,
      category: 'Oils',
      images: ['assets/images/products/prod4.jpg'],
      stockCount: 32,
      rating: 4.6,
      reviewCount: 67,
    ),
    Product(
      id: '5',
      title: 'Quinoa Puffs',
      icon: Icons.cookie,
      description: 'Crunchy quinoa puffs with natural seasoning',
      price: 199.99,
      category: 'Snacks',
      images: ['assets/images/products/prod5.jpg'],
      stockCount: 89,
      rating: 4.5,
      reviewCount: 145,
    ),
    Product(
      id: '6',
      title: 'Organic Spinach',
      icon: Icons.local_florist,
      description: 'Fresh organic spinach leaves, pesticide-free',
      price: 49.99,
      category: 'Vegetables',
      images: ['assets/images/products/prod6.jpg'],
      stockCount: 23,
      rating: 4.4,
      reviewCount: 56,
    ),
  ];

  List<Product> get filteredProducts {
    if (selectedCategory == 'All') return products;
    return products
        .where((product) => product.category == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
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
            // Hero Section
            _buildHeroSection(isDesktop),
            const SizedBox(height: 80),

            // Category Filter Section
            _buildCategorySection(isDesktop),
            const SizedBox(height: 50),

            // Products Grid Section
            _buildProductsSection(isDesktop),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3328),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title with animation
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, (1 - value) * 30),
                child: Opacity(
                  opacity: value,
                  child: Text(
                    'Our Premium Products',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: isDesktop ? 48 : 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),

          // Description
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1000),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, (1 - value) * 20),
                child: Opacity(
                  opacity: value,
                  child: Text(
                    isDesktop
                        ? 'Discover our carefully curated selection of authentic Indian food products. From aromatic spices and organic grains to fresh vegetables and premium oils, each product is selected for its exceptional quality and authenticity. We source directly from trusted farmers and suppliers to bring you the finest ingredients that celebrate the rich culinary heritage of India.'
                        : 'Discover our carefully curated selection of authentic Indian food products. From aromatic spices to organic grains, each product is selected for exceptional quality and authenticity.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: isDesktop ? 18 : 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCategorySection(bool isDesktop) {
    return Column(
      children: [
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 800),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, (1 - value) * 30),
              child: Opacity(
                opacity: value,
                child: Text(
                  'Product Categories',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: isDesktop ? 42 : 28,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D1B16),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: isDesktop ? 30 : 20),

        // Category Filter
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1000),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, (1 - value) * 20),
              child: Opacity(
                opacity: value,
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4A3328)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: const Color(0xFF4A3328),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF4A3328),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProductsSection(bool isDesktop) {
    if (isDesktop) {
      // Desktop: Keep grid layout
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          childAspectRatio: 1.3,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return _buildProductCard(product, index, isDesktop);
        },
      );
    } else {
      // Mobile/Tablet: Horizontal scrolling
      return TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1000),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, (1 - value) * 30),
            child: Opacity(
              opacity: value,
              child: SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return Container(
                      width: 180,
                      margin: const EdgeInsets.only(right: 15),
                      child: _buildProductCard(product, index, isDesktop),
                    );
                  },
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Widget _buildProductCard(Product product, int index, bool isDesktop) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1000 + (index * 200)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 40),
          child: Opacity(
            opacity: value,
            child: GestureDetector(
              onTap: () => _showProductDetail(context, product),
              child: Container(
                padding: EdgeInsets.all(isDesktop ? 20 : 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A3328),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            product.images.first,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFFFD700,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  product.icon,
                                  color: const Color(0xFFFFD700),
                                  size: isDesktop ? 40 : 30,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: isDesktop ? 15 : 10),

                    // Title
                    Text(
                      product.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: isDesktop ? 16 : 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isDesktop ? 8 : 6),

                    // Description
                    Text(
                      product.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: isDesktop ? 12 : 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: isDesktop ? 10 : 8),

                    // Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(5, (i) {
                          return Icon(
                            Icons.star,
                            size: 14,
                            color: i < product.rating.floor()
                                ? const Color(0xFFFFD700)
                                : Colors.grey.withOpacity(0.3),
                          );
                        }),
                        const SizedBox(width: 6),
                        Text(
                          '${product.rating}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isDesktop ? 10 : 8),

                    // Price and Stock
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '₹${product.price}',
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: isDesktop ? 16 : 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFFFD700),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: product.stockCount > 50
                                ? Colors.green.withOpacity(0.2)
                                : product.stockCount > 10
                                ? Colors.orange.withOpacity(0.2)
                                : Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${product.stockCount} available',
                            style: TextStyle(
                              fontSize: 12,
                              color: product.stockCount > 50
                                  ? Colors.green
                                  : product.stockCount > 10
                                  ? Colors.orange
                                  : Colors.red,
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
      },
    );
  }

  void _showProductDetail(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: const Color(0xFF4A3328),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  product.icon,
                  color: const Color(0xFFFFD700),
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                product.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              // Description
              Text(
                product.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // Rating and Reviews
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(5, (i) {
                    return Icon(
                      Icons.star,
                      size: 20,
                      color: i < product.rating.floor()
                          ? const Color(0xFFFFD700)
                          : Colors.grey.withOpacity(0.3),
                    );
                  }),
                  const SizedBox(width: 12),
                  Text(
                    '${product.rating} (${product.reviewCount} reviews)',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Price
              Text(
                '₹${product.price}',
                style: const TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFD700),
                ),
              ),
              const SizedBox(height: 25),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _addToCart(product);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A3328),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(color: Colors.white70),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Icon(Icons.close, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addToCart(Product product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} added to cart!'),
        backgroundColor: const Color(0xFFFFD700),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
