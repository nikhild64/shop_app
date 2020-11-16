import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' as cart;

class CartItem extends StatelessWidget {
  final cart.CardItem cartItem;

  CartItem({this.cartItem});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        Provider.of<cart.Cart>(context, listen: false)
            .removeCartItem(cartItem.id);
      },
      background: Container(
        padding: EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        color: Theme.of(context).errorColor,
        margin: EdgeInsets.all(5),
      ),
      direction: DismissDirection.endToStart,
      key: ValueKey(cartItem.id),
      child: Card(
        child: ListTile(
          title: Text(cartItem.title),
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$${cartItem.price.toString()}')),
          ),
          trailing: Text('${'X'} ${cartItem.quantity}'),
        ),
      ),
    );
  }
}
