// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CertificationsPage extends StatefulWidget {
  const CertificationsPage({super.key});

  @override
  State<CertificationsPage> createState() => _CertificationsPageState();
}

class _CertificationsPageState extends State<CertificationsPage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _cardsController;
  late AnimationController _trustController;
  late Animation<double> _headerAnimation;
  late Animation<double> _cardsAnimation;
  late Animation<double> _trustAnimation;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _cardsController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _trustController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut),
    );
    _cardsAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _cardsController, curve: Curves.easeOut));
    _trustAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _trustController, curve: Curves.elasticOut),
    );

    // Start animations
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _cardsController.forward();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      _trustController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardsController.dispose();
    _trustController.dispose();
    super.dispose();
  }

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
          colors: [Color(0xFFF5F5F5), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            AnimatedBuilder(
              animation: _headerAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - _headerAnimation.value) * 30),
                  child: Opacity(
                    opacity: _headerAnimation.value,
                    child: Column(
                      children: [
                        Text(
                          'Certifications & Quality Assurance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: _getHeaderFontSize(screenWidth),
                            fontWeight: FontWeight.w700,
                            color: const Color(
                              0xFF043C3E,
                            ), // Changed to match theme
                          ),
                        ),
                        SizedBox(height: screenWidth > 480 ? 20 : 12),
                        Text(
                          'We maintain the highest standards of quality and safety',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: _getSubHeaderFontSize(screenWidth),
                            color: const Color(
                              0xFF043C3E,
                            ).withOpacity(0.7), // Changed to match theme
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: screenWidth > 480 ? 50 : 30),

            // Certifications Grid
            AnimatedBuilder(
              animation: _cardsAnimation,
              builder: (context, child) {
                return _buildCertificationsGrid(screenWidth);
              },
            ),

            SizedBox(height: screenWidth > 480 ? 60 : 40),

            // Trust Badges
            AnimatedBuilder(
              animation: _trustAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _trustAnimation.value,
                  child: _buildTrustSection(screenWidth),
                );
              },
            ),
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

  double _getHeaderFontSize(double screenWidth) {
    if (screenWidth > 1200) return 48;
    if (screenWidth > 768) return 42;
    if (screenWidth > 480) return 36;
    return 28;
  }

  double _getSubHeaderFontSize(double screenWidth) {
    if (screenWidth > 768) return 18;
    if (screenWidth > 480) return 16;
    return 14;
  }

  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth > 900) return 4;
    if (screenWidth > 600) return 3;
    if (screenWidth > 400) return 2;
    return 1;
  }

  double _getChildAspectRatio(double screenWidth) {
    if (screenWidth > 768) return 1.0;
    if (screenWidth > 480) return 0.95;
    return 0.9;
  }

  Widget _buildCertificationsGrid(double screenWidth) {
    final certifications = [
      {
        'title': 'ISO 9001 Certified',
        'subtitle': 'Quality Management',
        'icon': Icons.verified_outlined,
        'image': 'assets/images/iso9001.jpg',
        'color': const Color(0xFF4CAF50),
      },
      {
        'title': 'MSME Certificate',
        'subtitle': 'Government Registered',
        'icon': Icons.business_outlined,
        'image': 'assets/images/msme.jpg',
        'color': const Color(0xFF2196F3),
      },
      {
        'title': 'FSSAI Registration',
        'subtitle': 'Food Safety Approved',
        'icon': Icons.food_bank_outlined,
        'image': 'assets/images/fssai.jpg',
        'color': const Color(0xFFFFC107),
      },
      {
        'title': 'GST Registration',
        'subtitle': 'Tax Compliant',
        'icon': Icons.eco_outlined,
        'image': 'assets/images/gst_rc.jpg',
        'color': const Color(0xFF8BC34A),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(screenWidth),
        crossAxisSpacing: screenWidth > 480 ? 30 : 16,
        mainAxisSpacing: screenWidth > 480 ? 30 : 16,
        childAspectRatio: _getChildAspectRatio(screenWidth),
      ),
      itemCount: certifications.length,
      itemBuilder: (context, index) {
        final cert = certifications[index];
        return _buildCertificationCard(
          cert['title'] as String,
          cert['subtitle'] as String,
          cert['icon'] as IconData,
          cert['image'] as String,
          cert['color'] as Color,
          index,
          screenWidth,
        );
      },
    );
  }

  Widget _buildCertificationCard(
    String title,
    String subtitle,
    IconData icon,
    String imagePath,
    Color iconColor,
    int index,
    double screenWidth,
  ) {
    final animationDelay = index * 100;
    final isMobile = screenWidth <= 480;

    return AnimatedBuilder(
      animation: _cardsAnimation,
      builder: (context, child) {
        final delayedValue = Tween<double>(begin: 0.0, end: 1.0)
            .animate(
              CurvedAnimation(
                parent: _cardsController,
                curve: Interval(
                  (animationDelay / 1000).clamp(0.0, 0.8),
                  1.0,
                  curve: Curves.easeOut,
                ),
              ),
            )
            .value;

        return Transform.translate(
          offset: Offset(0, (1 - delayedValue) * 30),
          child: Opacity(
            opacity: delayedValue,
            child: GestureDetector(
              onTap: () => _openCertificateDialog(title, imagePath),
              child: Container(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon
                    Container(
                      padding: EdgeInsets.all(isMobile ? 16 : 20),
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        icon,
                        size: isMobile ? 40 : 50,
                        color: iconColor,
                      ),
                    ),
                    SizedBox(height: isMobile ? 12 : 16),

                    // Title
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16,
                      ),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(
                            0xFF043C3E,
                          ), // Changed to match theme
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 6 : 8),

                    // Subtitle
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16,
                      ),
                      child: Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF666666),
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 8 : 12),

                    // Tap indicator
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Tap to view',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: isMobile ? 10 : 12,
                          color: const Color(0xFF888888),
                        ),
                      ),
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

  Widget _buildTrustSection(double screenWidth) {
    final isMobile = screenWidth <= 480;

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF043C3E), Color(0xFF032E30)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Trusted by Thousands',
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: isMobile ? 24 : 30),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: isMobile ? 24 : 40,
            runSpacing: 20,
            children: [
              _buildTrustBadge('⭐ 4.8/5', 'Customer Rating', screenWidth),
              _buildTrustBadge('🚚 24/7', 'Delivery Service', screenWidth),
              _buildTrustBadge('🔒 100%', 'Secure Payment', screenWidth),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrustBadge(String value, String label, double screenWidth) {
    final isMobile = screenWidth <= 480;

    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFC107),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: isMobile ? 12 : 14,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  void _openCertificateDialog(String title, String imagePath) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background tap to close
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                ),
              ),
              // Certificate image container
              Container(
                margin: const EdgeInsets.all(20),
                constraints: const BoxConstraints(
                  maxWidth: 500,
                  maxHeight: 600,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header - Changed color to match theme
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(
                          0xFF043C3E,
                        ), // Changed from brown to teal theme
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Certificate image
                    Flexible(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_not_supported_outlined,
                                      size: 50,
                                      color: Color(0xFF666666),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Certificate image not found',
                                      style: TextStyle(
                                        fontFamily: 'Josefin Sans',
                                        fontSize: 16,
                                        color: Color(0xFF666666),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
