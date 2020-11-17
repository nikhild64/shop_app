import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class ManageProductItem extends StatelessWidget {
  final Product product;
  ManageProductItem({this.product});
  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {}),
                IconButton(
                    icon:
                        Icon(Icons.delete, color: Theme.of(context).errorColor),
                    onPressed: () {})
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
