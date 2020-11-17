import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class ManageProductItem extends StatelessWidget {
  final Product product;
  ManageProductItem({this.product});
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.imageUrl),
          ),
          title: Text(product.title),
          trailing: FittedBox(
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(EditProduct.routeName, arguments: product);
                    }),
                IconButton(
                    icon:
                        Icon(Icons.delete, color: Theme.of(context).errorColor),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: Text('Are you sure?'),
                              content: Text(
                                  'This will delte the product permanetly'),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text('Yes')),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text('No'))
                              ],
                            );
                          }).then((value) async {
                        if (value) {
                          try {
                            await Provider.of<Products>(context, listen: false)
                                .deleteProduct(product.id);
                          } catch (error) {
                            scaffold
                                .showSnackBar(SnackBar(content: Text('error')));
                          }
                        }
                      });
                    })
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
