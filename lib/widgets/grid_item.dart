import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import '../providers/product.dart';

class GridItem extends StatelessWidget {
  /* final Product product;
  const GridItem({Key key, @required this.product}) : super(key: key);
 */
  /* final bool isFav;
  GridItem({this.isFav});
 */
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
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
            onPressed: () {
              cart.addToCart(product);
              Scaffold.of(context).hideCurrentSnackBar();

              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Product Added to the Cart!'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    cart.removeLatest(product);
                  },
                ),
              ));
            },
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
            icon: product.isFavourite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            onPressed: () {
              product.toggleFav();
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
