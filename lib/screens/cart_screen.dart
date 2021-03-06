import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/cart_item.dart';
import 'package:shop_app/widgets/main_drawer.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isloading = false;

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
                  _isloading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : RaisedButton(
                          onPressed: cart.cartAmount == 0
                              ? null
                              : () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          title: Text('Are you sure?'),
                                          content: Text(
                                              'Your order will be created, do you want to continue'),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: Text('Yes')),
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: Text('No'))
                                          ],
                                        );
                                      }).then((value) {
                                    if (value) {
                                      setState(() {
                                        _isloading = true;
                                      });

                                      Provider.of<Order>(context, listen: false)
                                          .orderNow(cart.items.values.toList(),
                                              cart.cartAmount)
                                          .then((value) {
                                        setState(() {
                                          _isloading = false;
                                        });
                                      });
                                      cart.clearCart();
                                    }
                                  });
                                },
                          child: Text(
                            'Order Now',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
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
