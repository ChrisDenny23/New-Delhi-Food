// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class FooterPage extends StatefulWidget {
  const FooterPage({super.key});

  @override
  State<FooterPage> createState() => _FooterPageState();
}

class _FooterPageState extends State<FooterPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 768;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF043C3E), Color(0xFF032E30)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                // Main Footer Content
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _getHorizontalPadding(screenWidth),
                    vertical: isMobile ? 32 : 48,
                  ),
                  child: isMobile
                      ? _buildMobileLayout()
                      : _buildDesktopLayout(),
                ),

                // Bottom Bar
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _getHorizontalPadding(screenWidth),
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: const Color(0xFF4CAF50).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: isMobile
                      ? _buildMobileBottomBar()
                      : _buildDesktopBottomBar(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth > 1200) return 80;
    if (screenWidth > 768) return 40;
    return 20;
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Info - Takes more space
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Delhi Foods',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF81C784),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Premium organic foods delivered fresh to your doorstep. Quality guaranteed, sustainability focused.',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              _buildSocialIcons(),
            ],
          ),
        ),

        const SizedBox(width: 60),

        // Quick Links
        Expanded(
          child: _buildFooterSection('Quick Links', [
            'About Us',
            'Products',
            'Certifications',
            'Privacy Policy',
            'Terms of Service',
          ]),
        ),

        const SizedBox(width: 40),

        // Services
        Expanded(
          child: _buildFooterSection('Our Services', [
            'Wholesale Supply',
            'Retail Distribution',
            'Custom Packaging',
            'Quality Assurance',
            'Fast Delivery',
          ]),
        ),

        const SizedBox(width: 40),

        // Contact
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Us',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              _buildContactItem(Icons.location_on, 'New Delhi, India'),
              _buildContactItem(Icons.phone, '+91 98100 26444'),
              _buildContactItem(Icons.email, 'newdelhifoods@gmail.com'),
              _buildContactItem(Icons.access_time, 'Mon-Sat: 9AM-6PM'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Header
        Center(
          child: Column(
            children: [
              Text(
                'New Delhi Foods',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Premium organic foods delivered fresh to your doorstep',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              _buildSocialIcons(),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Two Column Layout for sections
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  _buildFooterSection('Quick Links', [
                    'About Us',
                    'Products',
                    'Certifications',
                    'Privacy Policy',
                  ]),
                  const SizedBox(height: 24),
                  _buildFooterSection('Our Services', [
                    'Wholesale Supply',
                    'Retail Distribution',
                    'Custom Packaging',
                  ]),
                ],
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Us',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildContactItem(Icons.location_on, 'New Delhi, India'),
                  _buildContactItem(Icons.phone, '+91 98100 26444'),
                  _buildContactItem(Icons.email, 'newdelhifoods@gmail.com'),
                  _buildContactItem(Icons.access_time, 'Mon-Sat: 9AM-6PM'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: MediaQuery.of(context).size.width <= 768 ? 16 : 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width <= 768 ? 12 : 16),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                item,
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: MediaQuery.of(context).size.width <= 768 ? 13 : 14,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    final isMobile = MediaQuery.of(context).size.width <= 768;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF4CAF50), size: isMobile ? 16 : 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: isMobile ? 13 : 14,
                color: Colors.white.withOpacity(0.7),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    final isMobile = MediaQuery.of(context).size.width <= 768;

    return Row(
      mainAxisAlignment: isMobile
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        _buildSocialIcon(Icons.facebook, 'Facebook'),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.camera_alt, 'Instagram'),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.alternate_email, 'Twitter'),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.video_call, 'YouTube'),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String platform) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF4CAF50).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF4CAF50).withOpacity(0.9),
          size: 18,
        ),
      ),
    );
  }

  Widget _buildDesktopBottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '© 2025 New Delhi Foods. All rights reserved.',
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 14,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Terms of Service',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              'Made by Chris Denny',
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 14,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileBottomBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
            Text(' • ', style: TextStyle(color: Colors.white.withOpacity(0.4))),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Terms of Service',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '© 2025 New Delhi Foods. All rights reserved.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 12,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Made by Chris Denny | chrisdenny.in',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 11,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
