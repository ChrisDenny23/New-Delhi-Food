// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'auth_dialog.dart'; // Import the separated authentication dialog

class LandingHeroSection extends StatefulWidget {
  const LandingHeroSection({super.key});

  @override
  State<LandingHeroSection> createState() => _LandingHeroSectionState();
}

class _LandingHeroSectionState extends State<LandingHeroSection>
    with TickerProviderStateMixin {
  late AnimationController _heroController;
  late Animation<Offset> _heroSlideAnimation;
  late Animation<double> _heroFadeAnimation;

  @override
  void initState() {
    super.initState();

    _heroController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _heroSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _heroController, curve: Curves.easeOutCubic),
        );

    _heroFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroController, curve: Curves.easeInOut),
    );

    _heroController.forward();
  }

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600; // breakpoint for mobile devices

    return AnimatedBuilder(
      animation: _heroController,
      builder: (context, child) {
        return SlideTransition(
          position: _heroSlideAnimation,
          child: FadeTransition(
            opacity: _heroFadeAnimation,
            child: Container(
              width: double.infinity,
              height: screenHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_landing.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withAlpha(128),
                      Colors.black.withAlpha(77),
                      Colors.black.withAlpha(128),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      _buildHeader(context),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 8 : 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (!isMobile)
                                _buildBadge(), // Hide badge on mobile
                              SizedBox(height: isMobile ? 18 : 30),
                              _buildCenteredHeading(isMobile),
                              SizedBox(height: isMobile ? 12 : 20),
                              _buildCenteredDescription(isMobile),
                              SizedBox(height: isMobile ? 22 : 40),
                              _buildCenteredActionButtons(isMobile),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withAlpha(153), Colors.black.withAlpha(102)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 60 : 20,
            vertical: 15,
          ),
          child: Row(
            children: [
              // Logo and Company Name
              Expanded(
                child: Row(
                  children: [
                    // Animated Logo
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 800),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.white.withAlpha(77),
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(26),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Icon(
                                      Icons.restaurant,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 12),
                    // Company Name with animation
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 1000),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset((1 - value) * -20, 0),
                          child: Opacity(
                            opacity: value,
                            child: Text(
                              'New Delhi Foods',
                              style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: isDesktop ? 24 : 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Navigation Menu & Auth Buttons
              if (isDesktop) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNavItem('About', 1),
                    SizedBox(width: 40),
                    _buildNavItem('Products', 2),
                    SizedBox(width: 40),
                    _buildNavItem('Certifications', 3),
                    SizedBox(width: 40),
                    _buildAuthButton('Login', true),
                    SizedBox(width: 16),
                    _buildAuthButton('Sign Up', false),
                  ],
                ),
              ] else ...[
                IconButton(
                  onPressed: () {
                    _showMobileMenu(context);
                  },
                  icon: Icon(Icons.menu, color: Colors.white, size: 28),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String text, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * -10),
          child: Opacity(
            opacity: value,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  _scrollToSection(index);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAuthButton(String text, bool isLogin) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 900 + (isLogin ? 0 : 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _showAuthDialog(isLogin),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: isLogin
                      ? null
                      : LinearGradient(
                          colors: [Color(0xFFFFC107), Color(0xFFFFB300)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  color: isLogin ? Colors.transparent : null,
                  border: isLogin
                      ? Border.all(color: Colors.white.withAlpha(128), width: 1)
                      : null,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isLogin
                      ? null
                      : [
                          BoxShadow(
                            color: Color(0xFFFFC107).withAlpha(77),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isLogin ? Colors.white : Color(0xFF2D1B16),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBadge() {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(230),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(26),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, color: Color(0xFF4CAF50), size: 16),
                SizedBox(width: 8),
                Text(
                  'Fresh Taste Delivered',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D1B16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCenteredHeading(bool isMobile) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1200),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 20),
          child: Opacity(
            opacity: value,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: isDesktop ? 56 : (isMobile ? 30 : 40),
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
                children: [
                  TextSpan(
                    text: 'Experience ',
                    style: TextStyle(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(153),
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  TextSpan(
                    text: 'Quality Food\n',
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(153),
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                        Shadow(
                          color: Color(0xFFFFC107).withAlpha(77),
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  TextSpan(
                    text: 'Products from\n',
                    style: TextStyle(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(153),
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  TextSpan(
                    text: 'New Delhi Foods',
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(153),
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                        Shadow(
                          color: Color(0xFFFFC107).withAlpha(77),
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
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

  Widget _buildCenteredDescription(bool isMobile) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 15),
          child: Opacity(
            opacity: value,
            child: Container(
              constraints: BoxConstraints(maxWidth: 800),
              padding: EdgeInsets.all(isMobile ? 12 : 20),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(77),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white.withAlpha(51), width: 1),
              ),
              child: Text(
                "Discover the goodness of nature with New Delhi Foods. We bring you fresh, chemical-free, and certified organic food products straight from local farms to your home.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: isDesktop ? 18 : (isMobile ? 14 : 16),
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withAlpha(230),
                  height: 1.6,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCenteredActionButtons(bool isMobile) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 30),
          child: Opacity(
            opacity: value,
            child: isMobile
                ? Column(
                    children: [
                      _buildOrderNowButton(),
                      SizedBox(height: 16),
                      _buildLearnMoreButton(),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildOrderNowButton(),
                      SizedBox(width: 16),
                      _buildLearnMoreButton(),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildOrderNowButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFC107), Color(0xFFFFB300)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFFC107).withAlpha(102),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Scroll down to explore our products!'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Color(0xFF4CAF50),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Order Now',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D1B16),
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Color(0xFF2D1B16),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLearnMoreButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(102),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withAlpha(128), width: 2),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              _scrollToSection(1);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Learn More',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.info_outline, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _scrollToSection(int sectionIndex) {
    final sectionNames = ['Home', 'About', 'Products', 'Certifications'];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Scrolling to ${sectionNames[sectionIndex]} section...'),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _showAuthDialog(bool isLogin) {
    showDialog(
      context: context,
      builder: (context) => AuthDialog(isLogin: isLogin),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2D1B16), Color(0xFF3D2B26)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(128),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildMobileMenuItem(
                    'About',
                    Icons.info,
                    () => _scrollToSection(1),
                  ),
                  _buildMobileMenuItem(
                    'Products',
                    Icons.restaurant,
                    () => _scrollToSection(2),
                  ),
                  _buildMobileMenuItem(
                    'Certifications',
                    Icons.verified,
                    () => _scrollToSection(3),
                  ),
                  Divider(color: Colors.white.withAlpha(51)),
                  _buildMobileMenuItem(
                    'Login',
                    Icons.login,
                    () => _showAuthDialog(true),
                  ),
                  _buildMobileMenuItem(
                    'Sign Up',
                    Icons.person_add,
                    () => _showAuthDialog(false),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Josefin Sans',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
