import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import 'package:shop_app/widgets/manage_product_item.dart';

import 'edit_product_screen.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/manage-products';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        actions: [
          Container(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProduct.routeName);
              },
              icon: Icon(
                Icons.add,
                size: 30,
              ),
            ),
          )
        ],
        title: Text('Manage Products'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Provider.of<Products>(context, listen: false)
              .getAndSetProducts()
              .then((value) => print('value'))
              .catchError((error) {
            print(error);
          });
        },
        child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (ctx, index) {
              return ManageProductItem(product: products[index]);
            }),
      ),
    );
  }
}
