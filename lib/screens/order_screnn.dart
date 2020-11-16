import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import '../widgets/order_item.dart' as ord;

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView(
        children: [
          ...orderData.items
              .map((e) => ord.OrderItem(
                    orderItem: e,
                  ))
              .toList()
        ],
      ),
    );
  }
}
