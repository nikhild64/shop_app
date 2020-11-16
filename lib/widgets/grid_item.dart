import 'package:flutter/material.dart';
import '../models/product.dart';

class GridItem extends StatelessWidget {
  final Product product;
  const GridItem({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        product.imageUrl,
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
            product.title,
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
    );
  }
}
