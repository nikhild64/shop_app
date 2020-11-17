import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

import './screens/product_overview_screen.dart';
import './screens/product_details_screen.dart';
import 'providers/cart.dart';
import 'providers/order.dart';
import 'screens/cart_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/manage_products_screen.dart';
import 'screens/order_screnn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Products(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProvider(create: (ctx) => Order())
        ],
        child: MaterialApp(
          darkTheme: ThemeData(
            canvasColor: Colors.grey.shade200,
            primarySwatch: Colors.blueGrey,
            accentColor: Colors.orangeAccent.shade700,
          ),
          title: 'MyShop',
          theme: ThemeData(
            canvasColor: Colors.grey.shade200,
            primarySwatch: Colors.purple,
            accentColor: Colors.orangeAccent.shade700,
          ),
          initialRoute: '/',
          routes: {
            '/': (ctx) => ProductsOverview(),
            ProductDetail.routeName: (ctx) => ProductDetail(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            ManageProductsScreen.routeName: (ctx) => ManageProductsScreen(),
            EditProduct.routeName: (ctx) => EditProduct()
          },
        ));
  }
}
