import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import '../widgets/badge.dart';
import '../providers/product.dart';
import '../widgets/grid_item.dart';
import '../providers/products.dart';
import './product_details_screen.dart';
import 'cart_screen.dart';

class ProductsOverview extends StatefulWidget {
  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool onlyFav = false;
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = !onlyFav ? productsData.items : productsData.itemsFav;
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show Favourites'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Show ALL'),
                value: 1,
              )
            ],
            onSelected: (value) {
              setState(() {
                if (value == 0) {
                  onlyFav = true;
                } else {
                  onlyFav = false;
                }
              });
            },
          ),
          Badge(
            child: IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
            value: cart.cartItems.toString(),
          )
        ],
      ),
      drawer: MainDrawer(),
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
              child: ChangeNotifierProvider.value(
                  value: products[index], child: GridItem()),
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
