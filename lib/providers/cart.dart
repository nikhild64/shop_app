import 'package:flutter/material.dart';

import 'product.dart';

class CardItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CardItem({this.id, this.price, this.quantity, this.title});
}

class Cart with ChangeNotifier {
  Map<String, CardItem> _items = {};

  Map<String, CardItem> get items {
    return {..._items};
  }

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items.updateAll((key, value) => CardItem(
            id: value.id,
            price: value.price,
            quantity: value.quantity + 1,
            title: value.title,
          ));
    } else {
      _items.putIfAbsent(
          product.id,
          () => CardItem(
                id: product.id,
                price: product.price,
                quantity: 1,
                title: product.title,
              ));
    }

    notifyListeners();
  }

  void removeCartItem(String cartId) {
    _items.remove(cartId);
    notifyListeners();
  }

  int get cartItems {
    return _items.length;
  }

  double get cartAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total = total + value.price * value.quantity;
    });

    return total;
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
