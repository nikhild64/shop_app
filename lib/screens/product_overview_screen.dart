import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import '../widgets/grid_item.dart';
import '../providers/products.dart';
import './product_details_screen.dart';

class ProductsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: GridView.builder(
        itemBuilder: (ctx, index) {
          return InkWell(
            splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetail.routeName,
                  arguments: products[index].id);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GridItem(product: products[index]),
            ),
          );
        },
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
