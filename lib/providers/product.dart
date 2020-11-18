import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/urlData.dart' as urlData;

class Product with ChangeNotifier {
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

  Future<void> toggleFav() async {
    isFavourite = !isFavourite;
    notifyListeners();
    await http.patch(urlData.urlProdId.replaceAll('PRODID', id),
        body: json.encode({
          'isFavourite': isFavourite,
          'title': title,
          'description': description,
          'price': price,
          'imageUrl': imageUrl,
        }));
  }
}
