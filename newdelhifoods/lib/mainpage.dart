// Main Page - Single scrollable page with imported sections
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:newdelhifoods/about_us.dart';
import 'package:newdelhifoods/landing_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Landing Page Section (Full Screen)
            LandingHeroSection(),

            // About Us Section
            AboutPage(),

            // Products Section
            ProductsPage(),

            // Certifications Section
            CertificationsPage(),

            // Footer Section
            FooterPage(),
          ],
        ),
      ),
    );
  }
}

// About Us Page Component
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFFF5F5F5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          // Section title with animation
          TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 800),
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
                      color: Color(0xFF2D1B16),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 50),

          if (isDesktop)
            Row(
              children: [
                Expanded(child: _buildAboutContent()),
                SizedBox(width: 60),
                Expanded(child: _buildAboutImage()),
              ],
            )
          else
            Column(
              children: [
                _buildAboutImage(),
                SizedBox(height: 40),
                _buildAboutContent(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildAboutContent() {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset((1 - value) * -30, 0),
          child: Opacity(
            opacity: value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our Story',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFC107),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'New Delhi Foods was founded with a simple mission: to bring the finest organic and natural food products directly from farms to your table. We believe in sustainable farming practices, supporting local farmers, and providing our customers with the healthiest food choices.',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 18,
                    color: Color(0xFF2D1B16).withOpacity(0.8),
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 30),
                Wrap(
                  spacing: 40,
                  runSpacing: 20,
                  children: [
                    _buildStatItem('500+', 'Products'),
                    _buildStatItem('1000+', 'Happy Customers'),
                    _buildStatItem('50+', 'Partner Farms'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAboutImage() {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1200),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset((1 - value) * 30, 0),
          child: Opacity(
            opacity: value,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/about_image.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFC107), Color(0xFFFFB300)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.agriculture,
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
    );
  }

  Widget _buildStatItem(String number, String label) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1400),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Column(
            children: [
              Text(
                number,
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFC107),
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D1B16).withOpacity(0.7),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Products Page Component
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2D1B16), Color(0xFF3D2B26)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 800),
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
          SizedBox(height: 50),

          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop
                  ? 3
                  : (MediaQuery.of(context).size.width > 600 ? 2 : 1),
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 1.0,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              final products = [
                {
                  'title': 'Organic Grains',
                  'icon': Icons.grain,
                  'description': 'Fresh wheat, rice, and millets',
                },
                {
                  'title': 'Pure Spices',
                  'icon': Icons.spa,
                  'description': 'Aromatic and authentic spices',
                },
                {
                  'title': 'Healthy Pulses',
                  'icon': Icons.eco,
                  'description': 'Protein-rich lentils and beans',
                },
                {
                  'title': 'Natural Oils',
                  'icon': Icons.water_drop,
                  'description': 'Cold-pressed cooking oils',
                },
                {
                  'title': 'Organic Snacks',
                  'icon': Icons.cookie,
                  'description': 'Healthy and tasty snacks',
                },
                {
                  'title': 'Fresh Vegetables',
                  'icon': Icons.local_florist,
                  'description': 'Farm-fresh organic vegetables',
                },
              ];

              final product = products[index];
              return _buildProductCard(
                product['title'] as String,
                product['icon'] as IconData,
                product['description'] as String,
                index,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    String title,
    IconData icon,
    String description,
    int index,
  ) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withAlpha(26),
                    Colors.white.withAlpha(13),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withAlpha(51)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFC107), Color(0xFFFFB300)],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(icon, size: 40, color: Color(0xFF2D1B16)),
                  ),
                  SizedBox(height: 20),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 16,
                      color: Colors.white.withAlpha(179),
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

// Certifications Page Component
class CertificationsPage extends StatelessWidget {
  const CertificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF5F5F5), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, (1 - value) * 30),
                child: Opacity(
                  opacity: value,
                  child: Column(
                    children: [
                      Text(
                        'Certifications & Quality Assurance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: isDesktop ? 48 : 36,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D1B16),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'We maintain the highest standards of quality and safety',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 18,
                          color: Color(0xFF2D1B16).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 50),

          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 4 : 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 1.0,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              final certifications = [
                {'title': 'Organic Certified', 'icon': Icons.eco_outlined},
                {'title': 'FSSAI Approved', 'icon': Icons.verified_outlined},
                {'title': 'ISO 22000', 'icon': Icons.safety_check_outlined},
                {
                  'title': 'HACCP Certified',
                  'icon': Icons.health_and_safety_outlined,
                },
              ];

              final cert = certifications[index];
              return _buildCertificationCard(
                cert['title'] as String,
                cert['icon'] as IconData,
                index,
              );
            },
          ),

          SizedBox(height: 60),

          // Trust badges
          TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 1200),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2D1B16), Color(0xFF3D2B26)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Trusted by Thousands',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),
                      Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        spacing: 40,
                        runSpacing: 20,
                        children: [
                          _buildTrustBadge('⭐ 4.8/5', 'Customer Rating'),
                          _buildTrustBadge('🚚 24/7', 'Delivery Service'),
                          _buildTrustBadge('🔒 100%', 'Secure Payment'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationCard(String title, IconData icon, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 30),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(13),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 50, color: Color(0xFFFFC107)),
                  SizedBox(height: 15),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D1B16),
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

  Widget _buildTrustBadge(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFC107),
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 14,
            color: Colors.white.withAlpha(179),
          ),
        ),
      ],
    );
  }
}

// Footer Page Component
class FooterPage extends StatelessWidget {
  const FooterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 60 : 20,
              vertical: 50,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2D1B16), Color(0xFF1A0F0B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                // Main footer content
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildCompanyInfo()),
                      SizedBox(width: 60),
                      Expanded(child: _buildQuickLinks()),
                      SizedBox(width: 60),
                      Expanded(child: _buildContactInfo()),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildCompanyInfo(),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(child: _buildQuickLinks()),
                          SizedBox(width: 40),
                          Expanded(child: _buildContactInfo()),
                        ],
                      ),
                    ],
                  ),

                SizedBox(height: 40),
                Divider(color: Colors.white.withAlpha(51)),
                SizedBox(height: 20),

                // Bottom footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '© 2024 New Delhi Foods. All rights reserved.',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: 14,
                        color: Colors.white.withAlpha(179),
                      ),
                    ),
                    Row(
                      children: [
                        _buildSocialIcon(Icons.facebook),
                        SizedBox(width: 15),
                        _buildSocialIcon(Icons.camera_alt), // Instagram
                        SizedBox(width: 15),
                        _buildSocialIcon(Icons.alternate_email), // Twitter
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompanyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withAlpha(77)),
              ),
              child: Icon(Icons.restaurant, color: Colors.white, size: 28),
            ),
            SizedBox(width: 15),
            Text(
              'New Delhi Foods',
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          'Bringing you the finest organic and natural food products directly from farms to your table. Quality, freshness, and sustainability in every bite.',
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 16,
            color: Colors.white.withAlpha(179),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        _buildFooterLink('About Us'),
        _buildFooterLink('Products'),
        _buildFooterLink('Certifications'),
        _buildFooterLink('Privacy Policy'),
        _buildFooterLink('Terms of Service'),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Info',
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        _buildContactItem(Icons.location_on, 'New Delhi, India'),
        _buildContactItem(Icons.phone, '+91 98765 43210'),
        _buildContactItem(Icons.email, 'info@newdelhifoods.com'),
        _buildContactItem(Icons.access_time, 'Mon-Sat: 9AM-6PM'),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {},
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: 16,
              color: Colors.white.withAlpha(179),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFFFFC107), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 16,
                color: Colors.white.withAlpha(179),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
