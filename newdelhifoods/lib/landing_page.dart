// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'header_section.dart';
import 'hero_section.dart';
import 'categories_section.dart';

class LandingHeroSection extends StatelessWidget {
  const LandingHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          // Top Header Section
          HeaderSection(),
          // Hero Section
          HeroSection(),
          // Categories Section
          CategoriesSection(),
        ],
      ),
    );
  }
}
