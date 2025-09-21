// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: screenWidth,
      constraints: BoxConstraints(
        minHeight: isMobile ? 400 : 500,
        maxHeight: isMobile ? 500 : 600,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2D5A4A),
        image: DecorationImage(
          image: AssetImage(
            isMobile
                ? 'assets/images/landing_mobile.jpg'
                : 'assets/images/landing_background.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 20 : 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isMobile) ...[
              // Mobile Search Bar
              Container(
                height: 40,
                margin: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for products...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],

            // Hero Content
            if (!isMobile)
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Content
                    Expanded(flex: 3, child: _buildHeroContent(isMobile)),
                    const SizedBox(width: 60),
                  ],
                ),
              )
            else
              Expanded(child: Center(child: _buildHeroContent(isMobile))),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroContent(bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Main Heading
        Text(
          'We bring the store\nto your door',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: isMobile ? 28 : 48,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: 20),

        // Description
        Text(
          'Get organic produce and sustainably sourced\ngroceries delivery at up to 4% off grocery.',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: isMobile ? 14 : 18,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.9),
            height: 1.6,
          ),
        ),

        const SizedBox(height: 30),

        // Shop Now Button
        Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Explore our products below!'),
                  backgroundColor: Color(0xFF4CAF50),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF9ACD32),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF9ACD32).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                'Shop now',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D5A4A),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
