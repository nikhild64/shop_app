import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import '../providers/products.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments;
    final product = Provider.of<Products>(
      context,
      listen: false,
    ).prodById(routeArgs);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: [
          Container(
              height: 300,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              style: TextStyle(fontSize: 26),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Provider.of<Cart>(context, listen: false).addToCart(product);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_basket,
                    color: Colors.white,
                    size: 23,
                  ),
                  Text(
                    'Add To Cart',
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
