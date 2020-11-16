import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_screnn.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Column(
        children: [
          AppBar(
            title: Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            leading: Icon(Icons.shop),
            title: Text('Shop'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
            leading: Icon(Icons.payment),
            title: Text('Orders'),
          )
        ],
      ),
    );
  }
}
