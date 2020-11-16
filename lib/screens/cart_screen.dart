import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/cart_item.dart';
import 'package:shop_app/widgets/main_drawer.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Total'),
                  Chip(
                    label: Text('\$ ${cart.cartAmount.toString()}'),
                    backgroundColor: Theme.of(context).primaryColorLight,
                  ),
                  RaisedButton(
                      onPressed: () {
                        Provider.of<Order>(context, listen: false).orderNow(
                            cart.items.values.toList(), cart.cartAmount);
                        cart.clearCart();
                      },
                      child: Text(
                        'Order Now',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ))
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return CartItem(
                      cartItem: cart.items.values.toList()[index],
                    );
                  },
                  itemCount: cart.items.length),
            )
          ],
        ),
      ),
    );
  }
}
