// cart_manager.dart
import 'package:flutter/material.dart';

class CartItem {
  final int id;
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
}

class CartManager extends ChangeNotifier {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addItem({
    required int id,
    required String name,
    required String subtitle,
    required String weight,
    required double price,
    required String image,
    required IconData icon,
  }) {
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
    notifyListeners();
  }

  void removeItem(int id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateQuantity(int id, int quantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  int getQuantity(int id) {
    final item = _items.firstWhere(
      (item) => item.id == id,
      orElse: () => CartItem(
        id: -1,
        name: '',
        subtitle: '',
        weight: '',
        price: 0,
        image: '',
        icon: Icons.error,
        quantity: 0,
      ),
    );
    return item.id == -1 ? 0 : item.quantity;
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
