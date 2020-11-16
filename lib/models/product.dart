import 'package:flutter/cupertino.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  Product(
      {@required this.description,
      @required this.id,
      @required this.imageUrl,
      this.isFavourite = false,
      @required this.price,
      @required this.title});
}
