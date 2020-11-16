import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/main_drawer.dart';
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
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
