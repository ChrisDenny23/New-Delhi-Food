// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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

            // Vision, Mission, Values Cards
            _buildInfoCardsSection(isDesktop),
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
                    'About New Delhi Foods',
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
                        ? 'New Delhi Foods delivers fresh, quality food products rooted in Indian tradition, focusing on freshness and customer satisfaction. We offer a diverse range including fresh produce, dairy, bakery, canned goods, frozen foods, and beverages, catering to everyday needs with authenticity.\n Our mission is to be India\'s most trusted source for fresh and authentic foods, providing unmatched quality and service. Committed to quality, freshness, and customer satisfaction, we aim to exceed expectations with every product we offer.'
                        : 'New Delhi Foods delivers fresh, quality food products rooted in Indian tradition. We offer a diverse range including fresh produce, dairy, bakery, canned goods, frozen foods, and beverages.\n\nOur mission is to be India\'s most trusted source for fresh and authentic foods with unmatched quality and service.',
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

          // Image
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1200),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: Container(
                    height: isDesktop ? 300 : 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/about.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFD700), Color(0xFFFFB300)],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.storefront,
                                size: isDesktop ? 100 : 60,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCardsSection(bool isDesktop) {
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
                  'Our Core Values',
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
        SizedBox(height: isDesktop ? 50 : 30),

        if (isDesktop)
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  Icons.visibility,
                  'Vision',
                  'To be India\'s most trusted source for fresh and authentic foods.',
                  0,
                  isDesktop,
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: _buildInfoCard(
                  Icons.flag,
                  'Mission',
                  'Providing fresh, authentic food products with unmatched quality and service.',
                  200,
                  isDesktop,
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: _buildInfoCard(
                  Icons.star,
                  'Values',
                  'Committed to quality, freshness, and customer satisfaction.',
                  400,
                  isDesktop,
                ),
              ),
            ],
          )
        else
          Column(
            children: [
              _buildInfoCard(
                Icons.visibility,
                'Vision',
                'India\'s most trusted source for fresh foods.',
                0,
                isDesktop,
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                Icons.flag,
                'Mission',
                'Providing fresh, authentic food products with quality service.',
                200,
                isDesktop,
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                Icons.star,
                'Values',
                'Quality, freshness, and customer satisfaction.',
                400,
                isDesktop,
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildInfoCard(
    IconData icon,
    String title,
    String description,
    int delay,
    bool isDesktop,
  ) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1000 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 40),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: EdgeInsets.all(isDesktop ? 30 : 20),
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
                children: [
                  Container(
                    padding: EdgeInsets.all(isDesktop ? 16 : 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      icon,
                      color: const Color(0xFFFFD700),
                      size: isDesktop ? 32 : 28,
                    ),
                  ),
                  SizedBox(height: isDesktop ? 20 : 15),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: isDesktop ? 24 : 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: isDesktop ? 12 : 8),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: isDesktop ? 16 : 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
