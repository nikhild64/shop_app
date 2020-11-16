import 'dart:math';

import 'package:flutter/material.dart';
import '../providers/order.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem orderItem;

  const OrderItem({this.orderItem});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        ListTile(
          title: Text('\$' + widget.orderItem.amount.toString()),
          subtitle: Text(
              DateFormat().add_MMMMEEEEd().format(widget.orderItem.dateTime)),
          trailing: IconButton(
            icon: Icon(
              !isExpanded ? Icons.expand_more : Icons.expand_less,
            ),
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
        ),
        if (isExpanded)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: min(widget.orderItem.products.length * 20.0 + 10, 100),
            child: ListView(children: [
              ...widget.orderItem.products.map((e) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.title),
                    Text('${e.quantity} X \$${e.price}')
                  ],
                );
              }).toList()
            ]),
          )
      ],
    ));
  }
}
