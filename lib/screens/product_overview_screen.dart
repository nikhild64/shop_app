import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            splashColor: Theme.of(context).accentColor,
            radius: 100,
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetail.routeName,
                  arguments: products[index].id);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GridTile(
                child: Image.network(
                  products[index].imageUrl,
                  fit: BoxFit.cover,
                ),
                footer: Container(
                  alignment: Alignment.center,
                  height: 30,
                  color: Colors.black87,
                  width: double.infinity,
                  child: GridTileBar(
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.shopping_cart),
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text(
                      products[index].title,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {},
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
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
