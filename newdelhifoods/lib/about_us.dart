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
                    'New Delhi Foods delivers fresh, quality food products rooted in Indian tradition, focusing on freshness and customer satisfaction. We offer a diverse range including fresh produce, dairy, bakery, canned goods, frozen foods, and beverages, catering to everyday needs with authenticity.\n Our mission is to be India\'s most trusted source for fresh and authentic foods, providing unmatched quality and service. Committed to quality, freshness, and customer satisfaction, we aim to exceed expectations with every product we offer.',

                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 18,
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
                    height: 300,
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
                            child: const Center(
                              child: Icon(
                                Icons.storefront,
                                size: 100,
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
                    fontSize: isDesktop ? 42 : 32,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D1B16),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 50),

        if (isDesktop)
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  Icons.visibility,
                  'Vision',
                  'To be India\'s most trusted source for fresh and authentic foods.',
                  0,
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: _buildInfoCard(
                  Icons.flag,
                  'Mission',
                  'Providing fresh, authentic food products with unmatched quality and service.',
                  200,
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: _buildInfoCard(
                  Icons.star,
                  'Values',
                  'Committed to quality, freshness, and customer satisfaction.',
                  400,
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
                'To be India\'s most trusted source for fresh and authentic foods.',
                0,
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                Icons.flag,
                'Mission',
                'Providing fresh, authentic food products with unmatched quality and service.',
                200,
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                Icons.star,
                'Values',
                'Committed to quality, freshness, and customer satisfaction.',
                400,
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
              padding: const EdgeInsets.all(30),
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
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, color: const Color(0xFFFFD700), size: 32),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 16,
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
