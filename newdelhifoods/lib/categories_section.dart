// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    final categories = [
      {
        'title': 'Organic Grains',
        'subtitle': 'Brown rice, quinoa, and other wholesome grains',
        'icon': Icons.grain,
        'color': const Color(0xFF8BC34A),
      },
      {
        'title': 'Pulses',
        'subtitle': 'Lentils, chickpeas, and other protein-rich pulses',
        'icon': Icons.circle,
        'color': const Color(0xFF795548),
      },
      {
        'title': 'Spices',
        'subtitle': 'Turmeric, cumin, coriander, and other aromatic spices',
        'icon': Icons.local_florist,
        'color': const Color(0xFFFF5722),
      },
      {
        'title': 'Snacks',
        'subtitle': 'Nutritious snack options, including nuts and seeds',
        'icon': Icons.fastfood,
        'color': const Color(0xFFFF9800),
      },
      {
        'title': 'Dry Fruits',
        'subtitle': 'Dried fruits, including dates, apricots, and prunes',
        'icon': Icons.dining,
        'color': const Color(0xFFE91E63),
      },
      {
        'title': 'Groceries',
        'subtitle': 'Other essential grocery items',
        'icon': Icons.shopping_basket,
        'color': const Color(0xFF2196F3),
      },
    ];

    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (isTablet ? 32 : 40),
        vertical: isMobile ? 16 : (isTablet ? 24 : 32),
      ),
      color: const Color(0xFFF5F5F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shop by Category',
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: isMobile ? 18 : (isTablet ? 22 : 24),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2D1B16),
            ),
          ),
          SizedBox(height: isMobile ? 16 : 20),
          SizedBox(
            height: isMobile ? 120 : (isTablet ? 130 : 140),
            child: Row(
              children: [
                // Categories List
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Container(
                        width: isMobile ? 120 : (isTablet ? 150 : 180),
                        margin: EdgeInsets.only(right: isMobile ? 12 : 16),
                        padding: EdgeInsets.all(isMobile ? 12 : 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: isMobile ? 32 : 40,
                              height: isMobile ? 32 : 40,
                              decoration: BoxDecoration(
                                color: category['color'] as Color,
                                borderRadius: BorderRadius.circular(
                                  isMobile ? 10 : 12,
                                ),
                              ),
                              child: Icon(
                                category['icon'] as IconData,
                                color: Colors.white,
                                size: isMobile ? 16 : 20,
                              ),
                            ),
                            SizedBox(height: isMobile ? 8 : 12),
                            Text(
                              category['title'] as String,
                              style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: isMobile ? 12 : (isTablet ? 14 : 16),
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2D1B16),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: isMobile ? 2 : 4),
                            Text(
                              category['subtitle'] as String,
                              style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: isMobile ? 10 : (isTablet ? 12 : 14),
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                              maxLines: isMobile ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // See All Button (Desktop and Tablet only)
                if (!isMobile) ...[
                  SizedBox(width: isMobile ? 12 : 16),
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Show all categories'),
                            backgroundColor: Color(0xFF4CAF50),
                          ),
                        );
                      },
                      child: Container(
                        width: isTablet ? 70 : 80,
                        height: isTablet ? 70 : 80,
                        padding: EdgeInsets.all(isTablet ? 10 : 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9ACD32),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(height: isTablet ? 6 : 8),
                            Text(
                              'See all',
                              style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: isTablet ? 11 : 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
