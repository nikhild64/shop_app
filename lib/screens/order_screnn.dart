import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import '../widgets/order_item.dart' as ord;

class OrderScreen extends StatefulWidget {
  static const routeName = '/order';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isloading = false;
  @override
  void initState() {
    setState(() {
      _isloading = true;
    });
    Provider.of<Order>(context, listen: false)
        .getAndSetOrders()
        .then((value) => setState(() {
              _isloading = false;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : ListView(
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
