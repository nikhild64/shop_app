import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

import './screens/product_overview_screen.dart';
import './screens/product_details_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.orange,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => ProductsOverview(),
          ProductDetail.routeName: (ctx) => ProductDetail(),
        },
      ),
    );
  }
}
