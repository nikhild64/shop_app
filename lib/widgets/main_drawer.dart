import 'package:flutter/material.dart';
import 'package:shop_app/screens/manage_products_screen.dart';
import 'package:shop_app/screens/order_screnn.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Column(
        children: [
          AppBar(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.supervised_user_circle,
                color: Theme.of(context).accentColor,
                size: 50,
              ),
            ),
            title: Text('Hi User,'),
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
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ManageProductsScreen.routeName);
            },
            leading: Icon(Icons.edit_outlined),
            title: Text('Manage Products'),
          )
        ],
      ),
    );
  }
}
