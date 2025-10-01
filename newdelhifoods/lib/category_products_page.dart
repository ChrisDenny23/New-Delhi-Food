// category_products_page.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'cart_manager.dart';

class CategoryProductsPage extends StatefulWidget {
  final String categoryTitle;
  final Color categoryColor;

  const CategoryProductsPage({
    super.key,
    required this.categoryTitle,
    required this.categoryColor,
  });

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  final CartManager cartManager = CartManager();

  // Comprehensive product data by category
  final Map<String, List<Map<String, dynamic>>> categoryProducts = {
    'Organic Grains': [
      {
        'name': 'Brown Rice',
        'subtitle': 'Organic',
        'weight': '1 kg',
        'image': 'assets/images/brown_rice.jpg',
        'icon': Icons.rice_bowl,
      },
      {
        'name': 'White Rice',
        'subtitle': 'Premium',
        'weight': '1 kg',
        'image': 'assets/images/white_rice.jpg',
        'icon': Icons.rice_bowl,
      },
      {
        'name': 'Basmati Rice',
        'subtitle': 'Aromatic',
        'weight': '1 kg',
        'image': 'assets/images/basmati_rice.jpg',
        'icon': Icons.rice_bowl,
      },
      {
        'name': 'Quinoa',
        'subtitle': 'Superfood',
        'weight': '500 gm',
        'image': 'assets/images/quinoa.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Oats',
        'subtitle': 'Rolled',
        'weight': '1 kg',
        'image': 'assets/images/oats.jpg',
        'icon': Icons.breakfast_dining,
      },
      {
        'name': 'Pearl Millet',
        'subtitle': 'Bajra',
        'weight': '500 gm',
        'image': 'assets/images/pearl_millet.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Finger Millet',
        'subtitle': 'Ragi',
        'weight': '500 gm',
        'image': 'assets/images/finger_millet.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Foxtail Millet',
        'subtitle': 'Organic',
        'weight': '500 gm',
        'image': 'assets/images/foxtail_millet.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Barley',
        'subtitle': 'Whole Grain',
        'weight': '500 gm',
        'image': 'assets/images/barley.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Buckwheat',
        'subtitle': 'Gluten-free',
        'weight': '500 gm',
        'image': 'assets/images/buckwheat.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Amaranth',
        'subtitle': 'Rajgira',
        'weight': '500 gm',
        'image': 'assets/images/amaranth.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Sorghum',
        'subtitle': 'Jowar',
        'weight': '500 gm',
        'image': 'assets/images/sorghum.jpg',
        'icon': Icons.grain,
      },
    ],
    'Pulses': [
      {
        'name': 'Toor Dal',
        'subtitle': 'Split Pigeon Peas',
        'weight': '1 kg',
        'image': 'assets/images/toor_dal.jpg',
        'icon': Icons.circle,
      },
      {
        'name': 'Moong Dal',
        'subtitle': 'Split Green Gram',
        'weight': '500 gm',
        'image': 'assets/images/moong_dal.jpg',
        'icon': Icons.circle,
      },
      {
        'name': 'Chana Dal',
        'subtitle': 'Split Chickpeas',
        'weight': '500 gm',
        'image': 'assets/images/chana_dal.jpg',
        'icon': Icons.circle,
      },
      {
        'name': 'Masoor Dal',
        'subtitle': 'Red Lentils',
        'weight': '500 gm',
        'image': 'assets/images/masoor_dal.jpg',
        'icon': Icons.circle,
      },
      {
        'name': 'Urad Dal',
        'subtitle': 'Black Gram',
        'weight': '500 gm',
        'image': 'assets/images/urad_dal.jpg',
        'icon': Icons.circle,
      },
      {
        'name': 'Kabuli Chana',
        'subtitle': 'Chickpeas',
        'weight': '500 gm',
        'image': 'assets/images/kabuli_chana.jpg',
        'icon': Icons.circle,
      },
      {
        'name': 'Rajma',
        'subtitle': 'Kidney Beans',
        'weight': '500 gm',
        'image': 'assets/images/rajma.jpg',
        'icon': Icons.circle,
      },
      {
        'name': 'Green Moong',
        'subtitle': 'Whole Green Gram',
        'weight': '500 gm',
        'image': 'assets/images/green_moong.jpg',
        'icon': Icons.circle,
      },
      {
        'name': 'Black Chana',
        'subtitle': 'Kala Chana',
        'weight': '500 gm',
        'image': 'assets/images/black_chana.jpg',
        'icon': Icons.circle,
      },
      {
        'name': 'Moth Beans',
        'subtitle': 'Matki',
        'weight': '500 gm',
        'image': 'assets/images/moth_beans.jpg',
        'icon': Icons.circle,
      },
      {
        'name': 'Horse Gram',
        'subtitle': 'Kulthi',
        'weight': '500 gm',
        'image': 'assets/images/horse_gram.jpg',
        'icon': Icons.circle,
      },
      {
        'name': 'Yellow Peas',
        'subtitle': 'Matar Dal',
        'weight': '500 gm',
        'image': 'assets/images/yellow_peas.jpg',
        'icon': Icons.circle,
      },
    ],
    'Spices': [
      {
        'name': 'Turmeric Powder',
        'subtitle': 'Haldi',
        'weight': '100 gm',
        'image': 'assets/images/turmeric_powder.jpg',
        'icon': Icons.local_florist,
      },
      {
        'name': 'Red Chilli Powder',
        'subtitle': 'Lal Mirch',
        'weight': '100 gm',
        'image': 'assets/images/red_chilli_powder.jpg',
        'icon': Icons.local_fire_department,
      },
      {
        'name': 'Coriander Powder',
        'subtitle': 'Dhaniya',
        'weight': '100 gm',
        'image': 'assets/images/coriander_powder.jpg',
        'icon': Icons.local_florist,
      },
      {
        'name': 'Cumin Seeds',
        'subtitle': 'Jeera',
        'weight': '100 gm',
        'image': 'assets/images/cumin_seeds.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Garam Masala',
        'subtitle': 'Spice Mix',
        'weight': '100 gm',
        'image': 'assets/images/garam_masala.jpg',
        'icon': Icons.spa,
      },
      {
        'name': 'Black Pepper',
        'subtitle': 'Kali Mirch',
        'weight': '50 gm',
        'image': 'assets/images/black_pepper.jpg',
        'icon': Icons.circle,
      },
      {
        'name': 'Cardamom',
        'subtitle': 'Elaichi',
        'weight': '50 gm',
        'image': 'assets/images/cardamom.jpg',
        'icon': Icons.spa,
      },
      {
        'name': 'Cloves',
        'subtitle': 'Laung',
        'weight': '50 gm',
        'image': 'assets/images/cloves.jpg',
        'icon': Icons.spa,
      },
      {
        'name': 'Cinnamon',
        'subtitle': 'Dalchini',
        'weight': '50 gm',
        'image': 'assets/images/cinnamon.jpg',
        'icon': Icons.spa,
      },
      {
        'name': 'Bay Leaves',
        'subtitle': 'Tej Patta',
        'weight': '20 gm',
        'image': 'assets/images/bay_leaves.jpg',
        'icon': Icons.local_florist,
      },
      {
        'name': 'Mustard Seeds',
        'subtitle': 'Rai',
        'weight': '100 gm',
        'image': 'assets/images/mustard_seeds.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Fenugreek Seeds',
        'subtitle': 'Methi',
        'weight': '100 gm',
        'image': 'assets/images/fenugreek_seeds.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Asafoetida',
        'subtitle': 'Hing',
        'weight': '50 gm',
        'image': 'assets/images/asafoetida.jpg',
        'icon': Icons.spa,
      },
      {
        'name': 'Star Anise',
        'subtitle': 'Chakri Phool',
        'weight': '50 gm',
        'image': 'assets/images/star_anise.jpg',
        'icon': Icons.star,
      },
      {
        'name': 'Fennel Seeds',
        'subtitle': 'Saunf',
        'weight': '100 gm',
        'image': 'assets/images/fennel_seeds.jpg',
        'icon': Icons.grain,
      },
    ],
    'Snacks': [
      {
        'name': 'Roasted Peanuts',
        'subtitle': 'Salted',
        'weight': '200 gm',
        'image': 'assets/images/roasted_peanuts.jpg',
        'icon': Icons.fastfood,
      },
      {
        'name': 'Roasted Chickpeas',
        'subtitle': 'Bhuna Chana',
        'weight': '200 gm',
        'image': 'assets/images/roasted_chickpeas.jpg',
        'icon': Icons.fastfood,
      },
      {
        'name': 'Mixed Nuts',
        'subtitle': 'Premium',
        'weight': '250 gm',
        'image': 'assets/images/mixed_nuts.jpg',
        'icon': Icons.lunch_dining,
      },
      {
        'name': 'Pumpkin Seeds',
        'subtitle': 'Roasted',
        'weight': '150 gm',
        'image': 'assets/images/pumpkin_seeds.jpg',
        'icon': Icons.eco,
      },
      {
        'name': 'Sunflower Seeds',
        'subtitle': 'Raw',
        'weight': '150 gm',
        'image': 'assets/images/sunflower_seeds.jpg',
        'icon': Icons.wb_sunny,
      },
      {
        'name': 'Flax Seeds',
        'subtitle': 'Alsi',
        'weight': '200 gm',
        'image': 'assets/images/flax_seeds.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Chia Seeds',
        'subtitle': 'Superfood',
        'weight': '150 gm',
        'image': 'assets/images/chia_seeds.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Sesame Seeds',
        'subtitle': 'Til',
        'weight': '200 gm',
        'image': 'assets/images/sesame_seeds.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Makhana',
        'subtitle': 'Fox Nuts',
        'weight': '100 gm',
        'image': 'assets/images/makhana.jpg',
        'icon': Icons.spa,
      },
      {
        'name': 'Trail Mix',
        'subtitle': 'Energy Boost',
        'weight': '200 gm',
        'image': 'assets/images/trail_mix.jpg',
        'icon': Icons.lunch_dining,
      },
    ],
    'Dry Fruits': [
      {
        'name': 'Almonds',
        'subtitle': 'Premium',
        'weight': '250 gm',
        'image': 'assets/images/almonds.jpg',
        'icon': Icons.eco,
      },
      {
        'name': 'Cashew Nuts',
        'subtitle': 'Whole',
        'weight': '250 gm',
        'image': 'assets/images/cashew_nuts.jpg',
        'icon': Icons.inventory_2,
      },
      {
        'name': 'Pistachios',
        'subtitle': 'Salted',
        'weight': '200 gm',
        'image': 'assets/images/pistachios.jpg',
        'icon': Icons.agriculture,
      },
      {
        'name': 'Walnuts',
        'subtitle': 'Halves',
        'weight': '200 gm',
        'image': 'assets/images/walnuts.jpg',
        'icon': Icons.eco,
      },
      {
        'name': 'Raisins',
        'subtitle': 'Golden',
        'weight': '250 gm',
        'image': 'assets/images/raisins.jpg',
        'icon': Icons.fastfood,
      },
      {
        'name': 'Dates',
        'subtitle': 'Khajoor',
        'weight': '250 gm',
        'image': 'assets/images/dates.jpg',
        'icon': Icons.dining,
      },
      {
        'name': 'Dried Apricots',
        'subtitle': 'Khubani',
        'weight': '200 gm',
        'image': 'assets/images/dried_apricots.jpg',
        'icon': Icons.emoji_food_beverage,
      },
      {
        'name': 'Dried Figs',
        'subtitle': 'Anjeer',
        'weight': '200 gm',
        'image': 'assets/images/dried_figs.jpg',
        'icon': Icons.dining,
      },
      {
        'name': 'Prunes',
        'subtitle': 'Dried Plums',
        'weight': '200 gm',
        'image': 'assets/images/prunes.jpg',
        'icon': Icons.dining,
      },
      {
        'name': 'Brazil Nuts',
        'subtitle': 'Premium',
        'weight': '150 gm',
        'image': 'assets/images/brazil_nuts.jpg',
        'icon': Icons.eco,
      },
      {
        'name': 'Pine Nuts',
        'subtitle': 'Chilgoza',
        'weight': '100 gm',
        'image': 'assets/images/pine_nuts.jpg',
        'icon': Icons.park,
      },
      {
        'name': 'Dried Cranberries',
        'subtitle': 'Sweetened',
        'weight': '150 gm',
        'image': 'assets/images/dried_cranberries.jpg',
        'icon': Icons.fastfood,
      },
    ],
    'Groceries': [
      {
        'name': 'Raw Sugar',
        'subtitle': 'Unrefined',
        'weight': '1 kg',
        'image': 'assets/images/raw_sugar.jpg',
        'icon': Icons.local_grocery_store,
      },
      {
        'name': 'Jaggery',
        'subtitle': 'Gur',
        'weight': '500 gm',
        'image': 'assets/images/jaggery.jpg',
        'icon': Icons.dinner_dining,
      },
      {
        'name': 'Rock Salt',
        'subtitle': 'Sendha Namak',
        'weight': '500 gm',
        'image': 'assets/images/rock_salt.jpg',
        'icon': Icons.grain,
      },
      {
        'name': 'Sea Salt',
        'subtitle': 'Natural',
        'weight': '500 gm',
        'image': 'assets/images/sea_salt.jpg',
        'icon': Icons.water,
      },
      {
        'name': 'Honey',
        'subtitle': 'Pure',
        'weight': '500 ml',
        'image': 'assets/images/honey.jpg',
        'icon': Icons.egg,
      },
      {
        'name': 'Coconut Oil',
        'subtitle': 'Cold Pressed',
        'weight': '500 ml',
        'image': 'assets/images/coconut_oil.jpg',
        'icon': Icons.opacity,
      },
      {
        'name': 'Mustard Oil',
        'subtitle': 'Cold Pressed',
        'weight': '500 ml',
        'image': 'assets/images/mustard_oil.jpg',
        'icon': Icons.opacity,
      },
      {
        'name': 'Sesame Oil',
        'subtitle': 'Til Oil',
        'weight': '500 ml',
        'image': 'assets/images/sesame_oil.jpg',
        'icon': Icons.opacity,
      },
      {
        'name': 'Ghee',
        'subtitle': 'Pure Desi',
        'weight': '500 ml',
        'image': 'assets/images/ghee.jpg',
        'icon': Icons.local_dining,
      },
      {
        'name': 'Tamarind',
        'subtitle': 'Imli',
        'weight': '200 gm',
        'image': 'assets/images/tamarind.jpg',
        'icon': Icons.eco,
      },
      {
        'name': 'Dry Coconut',
        'subtitle': 'Copra',
        'weight': '200 gm',
        'image': 'assets/images/dry_coconut.jpg',
        'icon': Icons.spa,
      },
      {
        'name': 'Besan',
        'subtitle': 'Gram Flour',
        'weight': '500 gm',
        'image': 'assets/images/besan.jpg',
        'icon': Icons.dinner_dining,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final products = categoryProducts[widget.categoryTitle] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: widget.categoryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.categoryTitle,
          style: const TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_basket_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No products available',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : AnimatedBuilder(
              animation: cartManager,
              builder: (context, child) {
                return SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: _getHorizontalPadding(screenWidth),
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product count
                        Text(
                          '${products.length} Products',
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: screenWidth > 768 ? 16 : 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Products Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: _getCrossAxisCount(screenWidth),
                                childAspectRatio: _getChildAspectRatio(
                                  screenWidth,
                                ),
                                crossAxisSpacing: _getGridSpacing(screenWidth),
                                mainAxisSpacing: _getGridSpacing(screenWidth),
                              ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return _buildProductCard(
                              index,
                              product,
                              screenWidth,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildProductCard(
    int productIndex,
    Map<String, dynamic> product,
    double screenWidth,
  ) {
    final quantity = cartManager.getQuantity(productIndex);
    final isInCart = quantity > 0;
    final isMobile = screenWidth <= 480;

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(isMobile ? 12 : 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  product['image'] as String,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Icon(
                          product['icon'] as IconData,
                          size: _getFallbackIconSize(screenWidth),
                          color: widget.categoryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Product Info
          Expanded(
            flex: screenWidth <= 480 ? 3 : 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    product['name'] as String,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: _getProductNameFontSize(screenWidth),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2D1B16),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product['subtitle'] as String,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: _getSubtitleFontSize(screenWidth),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF666666),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product['weight'] as String,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: _getWeightFontSize(screenWidth),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF888888),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB87333).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Contact for price',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: _getContactTextSize(screenWidth),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFB87333),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add Button / Quantity Controls
          Container(
            width: double.infinity,
            height: _getButtonHeight(screenWidth),
            margin: EdgeInsets.fromLTRB(
              isMobile ? 8 : 16,
              0,
              isMobile ? 8 : 16,
              isMobile ? 8 : 16,
            ),
            child: isInCart
                ? Container(
                    decoration: BoxDecoration(
                      color: widget.categoryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (quantity > 1) {
                              cartManager.updateQuantity(
                                productIndex,
                                quantity - 1,
                              );
                            } else {
                              cartManager.removeItem(productIndex);
                            }
                          },
                          child: Container(
                            width: _getQuantityButtonSize(screenWidth),
                            height: _getQuantityButtonSize(screenWidth),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: widget.categoryColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: _getQuantityIconSize(screenWidth),
                            ),
                          ),
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: _getQuantityTextSize(screenWidth),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartManager.updateQuantity(
                              productIndex,
                              quantity + 1,
                            );
                          },
                          child: Container(
                            width: _getQuantityButtonSize(screenWidth),
                            height: _getQuantityButtonSize(screenWidth),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: widget.categoryColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: _getQuantityIconSize(screenWidth),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      cartManager.addItem(
                        id: productIndex,
                        name: product['name'] as String,
                        subtitle: product['subtitle'] as String,
                        weight: product['weight'] as String,
                        price: 0.0,
                        image: product['image'] as String,
                        icon: product['icon'] as IconData,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF0F0F0),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: const Color(0xFF2D1B16),
                      size: _getAddButtonIconSize(screenWidth),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Helper methods for responsive sizing
  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth > 1200) return 80;
    if (screenWidth > 768) return 60;
    if (screenWidth > 480) return 30;
    return 20;
  }

  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth > 1200) return 5;
    if (screenWidth > 900) return 4;
    if (screenWidth > 600) return 3;
    return 2;
  }

  double _getChildAspectRatio(double screenWidth) {
    if (screenWidth > 768) return 0.85;
    if (screenWidth > 480) return 0.8;
    return 0.75;
  }

  double _getGridSpacing(double screenWidth) {
    if (screenWidth > 768) return 20;
    if (screenWidth > 480) return 16;
    return 12;
  }

  double _getFallbackIconSize(double screenWidth) {
    if (screenWidth > 768) return 40;
    if (screenWidth > 480) return 36;
    return 32;
  }

  double _getProductNameFontSize(double screenWidth) {
    if (screenWidth > 1200) return 18;
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 14;
    return 12;
  }

  double _getSubtitleFontSize(double screenWidth) {
    if (screenWidth > 768) return 12;
    if (screenWidth > 480) return 11;
    return 10;
  }

  double _getWeightFontSize(double screenWidth) {
    if (screenWidth > 768) return 12;
    if (screenWidth > 480) return 11;
    return 10;
  }

  double _getContactTextSize(double screenWidth) {
    if (screenWidth > 768) return 12;
    if (screenWidth > 480) return 11;
    return 10;
  }

  double _getButtonHeight(double screenWidth) {
    if (screenWidth > 768) return 45;
    if (screenWidth > 480) return 40;
    return 36;
  }

  double _getQuantityButtonSize(double screenWidth) {
    if (screenWidth > 768) return 35;
    if (screenWidth > 480) return 30;
    return 26;
  }

  double _getQuantityIconSize(double screenWidth) {
    if (screenWidth > 768) return 20;
    if (screenWidth > 480) return 18;
    return 16;
  }

  double _getQuantityTextSize(double screenWidth) {
    if (screenWidth > 768) return 18;
    if (screenWidth > 480) return 17;
    return 16;
  }

  double _getAddButtonIconSize(double screenWidth) {
    if (screenWidth > 768) return 24;
    if (screenWidth > 480) return 22;
    return 20;
  }
}
