// Main Page - Single scrollable page with imported sections
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:newdelhifoods/about_us.dart';
import 'package:newdelhifoods/certifications.dart';
import 'package:newdelhifoods/footer.dart';
import 'package:newdelhifoods/newsletter.dart';
import 'package:newdelhifoods/product.dart';
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

            // Product Section
            ProductPage(),

            // About Section
            AboutUsPage(),

            // Certifications Section
            CertificationsPage(),

            // Newsletter Section
            NewsletterSection(),

            // Footer Section
            FooterPage(),
          ],
        ),
      ),
    );
  }
}
