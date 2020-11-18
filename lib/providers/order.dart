import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/urlData.dart' as urlData;
import 'dart:convert';
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

  Future<void> orderNow(List<CardItem> cartProducts, double total) async {
    if (cartProducts.isNotEmpty) {
      await http.post(urlData.urlOrder,
          body: json.encode({
            'products': cartProducts.map((e) {
              return {
                'id': e.id,
                'title': e.title,
                'quantity': e.quantity,
                'price': e.price,
              };
            }).toList(),
            'amount': total,
            'dateTime': DateTime.now().toIso8601String(),
            'id': DateTime.now().toString()
          }));
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

  Future<void> getAndSetOrders() async {
    final response = await http.get(urlData.urlOrder);
    final orderData = json.decode(response.body) as Map<String, dynamic>;
    final List<OrderItem> loadedOrders = [];
    if (orderData == null) {
      return;
    }
    orderData.forEach((key, value) {
      loadedOrders.add(OrderItem(
          id: key,
          amount: value['amount'],
          products: (value['products'] as List<dynamic>)
              .map((e) => CardItem(
                  id: e['id'],
                  price: e['price'],
                  quantity: e['quantity'],
                  title: e['title']))
              .toList(),
          dateTime: DateTime.parse(value['dateTime'])));
    });
    _items = loadedOrders;
    notifyListeners();
  }
}
