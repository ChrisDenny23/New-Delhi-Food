import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:newdelhifoods/config.dart';
import 'dart:convert';

class CartItem {
  final String id;
  final String name;
  final String subtitle;
  final String weight;
  final double price;
  final String image;
  final IconData icon;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.weight,
    required this.price,
    required this.image,
    required this.icon,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  // Convert to JSON for local storage
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'subtitle': subtitle,
    'weight': weight,
    'price': price,
    'image': image,
    'iconCode': icon.codePoint,
    'quantity': quantity,
  };

  // Create from JSON for local storage
  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json['id'],
    name: json['name'],
    subtitle: json['subtitle'],
    weight: json['weight'],
    price: (json['price'] ?? 0.0).toDouble(),
    image: json['image'],
    icon: IconData(
      json['iconCode'] ?? Icons.shopping_cart.codePoint,
      fontFamily: 'MaterialIcons',
    ),
    quantity: json['quantity'] ?? 1,
  );
}

class CartManager extends ChangeNotifier {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal() {
    _loadCartFromStorage();
  }

  final List<CartItem> _items = [];
  final _storage = const FlutterSecureStorage();
  final Dio _dio = Dio();
  bool _isLoggedIn = false;
  String? _accessToken;
  bool _isInitialized = false;

  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  // Initialize cart manager - check login status and sync if logged in
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _loadCartFromStorage();
    await _checkLoginStatus();

    if (_isLoggedIn) {
      debugPrint('Cart Manager: User is logged in, syncing with server...');
      await _syncWithServer();
    } else {
      debugPrint('Cart Manager: User not logged in, using local storage');
    }

    _isInitialized = true;
  }

  // Check if user is logged in
  Future<void> _checkLoginStatus() async {
    try {
      _accessToken = await _storage.read(key: 'access_token');
      _isLoggedIn = _accessToken != null && _accessToken!.isNotEmpty;
      debugPrint(
        'Cart Manager: Login status checked - Logged in: $_isLoggedIn',
      );
    } catch (e) {
      debugPrint('Cart Manager: Error checking login status: $e');
      _isLoggedIn = false;
    }
  }

  // Load cart from local storage
  Future<void> _loadCartFromStorage() async {
    try {
      final cartJson = await _storage.read(key: 'local_cart');
      if (cartJson != null && cartJson.isNotEmpty) {
        final List<dynamic> cartList = jsonDecode(cartJson);
        _items.clear();
        _items.addAll(cartList.map((item) => CartItem.fromJson(item)).toList());
        debugPrint(
          'Cart Manager: Loaded ${_items.length} items from local storage',
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Cart Manager: Error loading cart from storage: $e');
    }
  }

  // Save cart to local storage
  Future<void> _saveCartToStorage() async {
    try {
      final cartJson = jsonEncode(_items.map((item) => item.toJson()).toList());
      await _storage.write(key: 'local_cart', value: cartJson);
      debugPrint('Cart Manager: Saved ${_items.length} items to local storage');
    } catch (e) {
      debugPrint('Cart Manager: Error saving cart to storage: $e');
    }
  }

  // Sync local cart with server after login
  Future<void> _syncWithServer() async {
    if (!_isLoggedIn || _accessToken == null) return;

    try {
      debugPrint('Cart Manager: Starting server sync...');

      // First, try to load existing cart from server
      await _loadCartFromServer();

      // If we have local items, add them to server
      if (_items.isNotEmpty) {
        debugPrint(
          'Cart Manager: Syncing ${_items.length} local items to server...',
        );

        for (final localItem in List.from(_items)) {
          await _addItemToServerDirect(localItem.id, localItem.quantity);
        }

        // Clear local storage after successful sync
        await _storage.delete(key: 'local_cart');
        debugPrint('Cart Manager: Local storage cleared after sync');

        // Reload cart from server
        await _loadCartFromServer();
      }
    } catch (e) {
      debugPrint('Cart Manager: Error syncing with server: $e');
      // Keep local cart if server sync fails
    }
  }

  // Load cart from server
  Future<void> _loadCartFromServer() async {
    if (!_isLoggedIn || _accessToken == null) return;

    try {
      final response = await _dio.get(
        '$apiBaseUrl/cart/getcart',
        options: Options(headers: {'Authorization': 'Bearer $_accessToken'}),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final serverItems = response.data['items'] as List;
        _items.clear();

        for (final serverItem in serverItems) {
          final product = serverItem['product'];
          if (product != null) {
            _items.add(
              CartItem(
                id: product['id'],
                name: product['name'] ?? 'Unknown Product',
                subtitle: product['category'] ?? '',
                weight: '500g', // Default weight
                price: (product['price'] ?? 0).toDouble(),
                image: product['image_url'] ?? '',
                icon: Icons.inventory_2,
                quantity: serverItem['quantity'] ?? 1,
              ),
            );
          }
        }

        debugPrint('Cart Manager: Loaded ${_items.length} items from server');
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Cart Manager: Error loading cart from server: $e');
    }
  }

  // Add item to cart
  Future<void> addItem({
    required String id,
    required String name,
    required String subtitle,
    required String weight,
    required double price,
    required String image,
    required IconData icon,
  }) async {
    await _checkLoginStatus();

    if (_isLoggedIn) {
      // Try to add to server first
      bool serverSuccess = await _addItemToServer(id, 1);

      if (!serverSuccess) {
        // Fallback to local storage
        await _addItemToLocal(id, name, subtitle, weight, price, image, icon);
      }
    } else {
      // Add to local storage
      await _addItemToLocal(id, name, subtitle, weight, price, image, icon);
    }
  }

  // Add item to local storage
  Future<void> _addItemToLocal(
    String id,
    String name,
    String subtitle,
    String weight,
    double price,
    String image,
    IconData icon,
  ) async {
    final existingIndex = _items.indexWhere((item) => item.id == id);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(
        CartItem(
          id: id,
          name: name,
          subtitle: subtitle,
          weight: weight,
          price: price,
          image: image,
          icon: icon,
        ),
      );
    }

    await _saveCartToStorage();
    debugPrint('Cart Manager: Added item to local storage: $name');
    notifyListeners();
  }

  // Add item to server
  Future<bool> _addItemToServer(String productId, int quantity) async {
    try {
      if (_accessToken == null) return false;

      final response = await _dio.post(
        '$apiBaseUrl/cart/additem',
        data: {'productId': productId, 'quantity': quantity},
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Cart Manager: Successfully added item to server');
        await _loadCartFromServer(); // Refresh cart from server
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Cart Manager: Error adding item to server: $e');
      return false;
    }
  }

  // Direct add to server (for syncing)
  Future<bool> _addItemToServerDirect(String productId, int quantity) async {
    try {
      if (_accessToken == null) return false;

      final response = await _dio.post(
        '$apiBaseUrl/cart/additem',
        data: {'productId': productId, 'quantity': quantity},
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('Cart Manager: Error in direct server add: $e');
      return false;
    }
  }

  // Remove item from cart
  Future<void> removeItem(String id) async {
    await _checkLoginStatus();

    if (_isLoggedIn) {
      bool serverSuccess = await _removeItemFromServer(id);

      if (!serverSuccess) {
        // Fallback to local removal
        await _removeItemFromLocal(id);
      }
    } else {
      // Remove from local storage
      await _removeItemFromLocal(id);
    }
  }

  // Remove item from local storage
  Future<void> _removeItemFromLocal(String id) async {
    _items.removeWhere((item) => item.id == id);
    await _saveCartToStorage();
    debugPrint('Cart Manager: Removed item from local storage: $id');
    notifyListeners();
  }

  // Remove item from server
  Future<bool> _removeItemFromServer(String productId) async {
    try {
      if (_accessToken == null) return false;

      // Find the cart item
      final cartItem = _items.firstWhere(
        (item) => item.id == productId,
        orElse: () => CartItem(
          id: '',
          name: '',
          subtitle: '',
          weight: '',
          price: 0,
          image: '',
          icon: Icons.error,
        ),
      );

      if (cartItem.id.isEmpty) return false;

      // For now, we'll use the product ID as cart item ID
      // This might need adjustment based on your actual cart item structure
      final response = await _dio.delete(
        '$apiBaseUrl/cart/deleteitem',
        data: {'cartItemId': cartItem.id},
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('Cart Manager: Successfully removed item from server');
        await _loadCartFromServer(); // Refresh cart from server
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Cart Manager: Error removing item from server: $e');
      return false;
    }
  }

  // Update quantity
  Future<void> updateQuantity(String id, int quantity) async {
    await _checkLoginStatus();

    if (quantity <= 0) {
      await removeItem(id);
      return;
    }

    if (_isLoggedIn) {
      bool serverSuccess = await _updateQuantityOnServer(id, quantity);

      if (!serverSuccess) {
        // Fallback to local update
        await _updateQuantityLocal(id, quantity);
      }
    } else {
      // Update in local storage
      await _updateQuantityLocal(id, quantity);
    }
  }

  // Update quantity locally
  Future<void> _updateQuantityLocal(String id, int quantity) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index].quantity = quantity;
      await _saveCartToStorage();
      debugPrint('Cart Manager: Updated quantity locally: $id -> $quantity');
      notifyListeners();
    }
  }

  // Update quantity on server
  Future<bool> _updateQuantityOnServer(
    String productId,
    int newQuantity,
  ) async {
    try {
      if (_accessToken == null) return false;

      final cartItem = _items.firstWhere(
        (item) => item.id == productId,
        orElse: () => CartItem(
          id: '',
          name: '',
          subtitle: '',
          weight: '',
          price: 0,
          image: '',
          icon: Icons.error,
        ),
      );

      if (cartItem.id.isEmpty) return false;

      final quantityDiff = newQuantity - cartItem.quantity;

      final response = await _dio.patch(
        '$apiBaseUrl/cart/changequantity',
        data: {'cartItemId': cartItem.id, 'quantity': quantityDiff},
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('Cart Manager: Successfully updated quantity on server');
        await _loadCartFromServer(); // Refresh cart from server
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Cart Manager: Error updating quantity on server: $e');
      return false;
    }
  }

  // Get quantity for a product
  int getQuantity(String id) {
    final item = _items.firstWhere(
      (item) => item.id == id,
      orElse: () => CartItem(
        id: '',
        name: '',
        subtitle: '',
        weight: '',
        price: 0,
        image: '',
        icon: Icons.error,
        quantity: 0,
      ),
    );
    return item.id.isEmpty ? 0 : item.quantity;
  }

  // Clear cart
  Future<void> clearCart() async {
    _items.clear();
    await _storage.delete(key: 'local_cart');
    debugPrint('Cart Manager: Cart cleared');
    notifyListeners();
  }

  // Handle login - sync local cart to server
  Future<void> onUserLogin(String accessToken) async {
    debugPrint('Cart Manager: User logged in, starting sync...');
    _accessToken = accessToken;
    _isLoggedIn = true;
    await _syncWithServer();
  }

  // Handle logout - clear server cart, keep local if needed
  Future<void> onUserLogout() async {
    debugPrint('Cart Manager: User logged out');
    _accessToken = null;
    _isLoggedIn = false;
    // Optionally save current cart to local storage
    await _saveCartToStorage();
  }

  // Force refresh cart (useful for debugging)
  Future<void> refreshCart() async {
    await _checkLoginStatus();
    if (_isLoggedIn) {
      await _loadCartFromServer();
    } else {
      await _loadCartFromStorage();
    }
  }
}
