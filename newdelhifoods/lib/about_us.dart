// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(screenWidth),
        vertical: screenWidth > 480 ? 40 : 24,
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
            _buildHeroSection(screenWidth),
            SizedBox(height: screenWidth > 480 ? 40 : 24),

            // Story Section
            _buildStorySection(screenWidth),
            SizedBox(height: screenWidth > 480 ? 40 : 24),

            // Why Choose Us Section
            _buildWhyChooseUsSection(screenWidth),
            SizedBox(height: screenWidth > 480 ? 40 : 24),
          ],
        ),
      ),
    );
  }

  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth > 1200) return 80;
    if (screenWidth > 768) return 60;
    if (screenWidth > 480) return 30;
    return 16;
  }

  Widget _buildHeroSection(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: screenWidth > 768
            ? 48
            : screenWidth > 480
            ? 32
            : 24,
        horizontal: screenWidth > 768 ? 32 : 20,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF043C3E), Color(0xFF032E30)],
        ),
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
        children: [
          Text(
            'Experience the Authentic Taste of India with New Delhi Foods',
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: _getHeroTitleSize(screenWidth),
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenWidth > 480 ? 16 : 12),
          Text(
            'Immerse yourself in the rich flavors and aromas of traditional Indian cuisine, crafted with love and care using only the finest organic ingredients. At New Delhi Foods, we\'re passionate about preserving the essence of Indian culture through our pure, homemade, and organic food products.',
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: _getHeroSubtitleSize(screenWidth),
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStorySection(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        screenWidth > 768
            ? 32
            : screenWidth > 480
            ? 24
            : 20,
      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Story',
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: _getSectionTitleSize(screenWidth),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2D1B16),
            ),
          ),
          SizedBox(height: screenWidth > 480 ? 16 : 12),
          Text(
            'Inspired by the ancient wisdom of Indian cooking, our family-owned business is dedicated to sharing the authentic taste of India with the world. We believe in the importance of wholesome, chemical-free food that nourishes both body and soul.',
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: _getBodyTextSize(screenWidth),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF666666),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseUsSection(double screenWidth) {
    final reasons = [
      {
        'icon': Icons.verified,
        'title': 'Pure Organic Ingredients',
        'description':
            'We use only the finest, certified organic ingredients, ensuring our products are free from chemicals and additives.',
      },
      {
        'icon': Icons.favorite,
        'title': 'Homemade with Love',
        'description':
            'Our products are crafted in small batches, with care and attention to detail, to preserve the authenticity of Indian cuisine.',
      },
      {
        'icon': Icons.agriculture,
        'title': 'Supporting Local Farmers',
        'description':
            'We source our ingredients from local, organic farmers, promoting sustainable agriculture and supporting our community.',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        screenWidth > 768
            ? 32
            : screenWidth > 480
            ? 24
            : 20,
      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Choose Us?',
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: _getSectionTitleSize(screenWidth),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2D1B16),
            ),
          ),
          SizedBox(height: screenWidth > 480 ? 20 : 16),
          ...reasons.map(
            (reason) => _buildReasonItem(
              reason['icon'] as IconData,
              reason['title'] as String,
              reason['description'] as String,
              screenWidth,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonItem(
    IconData icon,
    String title,
    String description,
    double screenWidth,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth > 480 ? 20 : 16),
      padding: EdgeInsets.all(screenWidth > 480 ? 20 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF7CB342).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth > 480 ? 48 : 40,
            height: screenWidth > 480 ? 48 : 40,
            decoration: BoxDecoration(
              color: const Color(0xFF7CB342).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF7CB342),
              size: screenWidth > 480 ? 24 : 20,
            ),
          ),
          SizedBox(width: screenWidth > 480 ? 16 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: _getReasonTitleSize(screenWidth),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2D1B16),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: _getReasonDescSize(screenWidth),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF666666),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods for responsive sizing - optimized for mobile
  double _getHeroTitleSize(double screenWidth) {
    if (screenWidth > 1200) return 32;
    if (screenWidth > 768) return 28;
    if (screenWidth > 480) return 22;
    return 18;
  }

  double _getHeroSubtitleSize(double screenWidth) {
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 15;
    return 13;
  }

  double _getSectionTitleSize(double screenWidth) {
    if (screenWidth > 1200) return 28;
    if (screenWidth > 768) return 24;
    if (screenWidth > 480) return 20;
    return 18;
  }

  double _getBodyTextSize(double screenWidth) {
    if (screenWidth > 768) return 15;
    if (screenWidth > 480) return 14;
    return 13;
  }

  double _getReasonTitleSize(double screenWidth) {
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 15;
    return 14;
  }

  double _getReasonDescSize(double screenWidth) {
    if (screenWidth > 768) return 14;
    if (screenWidth > 480) return 13;
    return 12;
  }
}
