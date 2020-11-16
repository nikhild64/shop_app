import 'package:flutter/foundation.dart';

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CardItem> products;
  final DateTime dateTime;
  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _items = [];
  List<OrderItem> get items {
    return [..._items];
  }

  void orderNow(List<CardItem> cartProducts, double total) {
    if (cartProducts.isNotEmpty) {
      _items.insert(
          0,
          OrderItem(
              products: cartProducts,
              amount: total,
              dateTime: DateTime.now(),
              id: DateTime.now().toString()));
      notifyListeners();
    }
  }
}
