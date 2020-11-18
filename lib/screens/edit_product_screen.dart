import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProduct extends StatefulWidget {
  static const routeName = '/edit-page';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  var _imgUrlcontroller = TextEditingController();
  var _product = Product(
      description: '',
      id: null,
      imageUrl: '',
      price: 0,
      title: '',
      isFavourite: false);
  bool isInit = true;
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  void setUrl() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      _product = ModalRoute.of(context).settings.arguments;
      if (_product != null) {
        _imgUrlcontroller.text = _product.imageUrl;
      } else {
        _product = Product(
            description: '',
            id: null,
            imageUrl: '',
            price: null,
            title: '',
            isFavourite: false);
      }
      isInit = false;
    }
    super.didChangeDependencies();
  }

  void submitForm() {
    setState(() {
      _isLoading = true;
    });
    var isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      if (_product.id != null) {
        Provider.of<Products>(context, listen: false)
            .updateProduct(_product.id, _product)
            .then((value) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        });
      } else {
        Provider.of<Products>(context, listen: false)
            .addProduct(_product)
            .then((value) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit/Add Product'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: submitForm)],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _product.title,
                      validator: (value) {
                        if (value.length == 0) {
                          return 'Value is required';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _product = Product(
                            description: _product.description,
                            id: _product.id,
                            imageUrl: _product.imageUrl,
                            price: _product.price,
                            title: value,
                            isFavourite: _product.isFavourite);
                      },
                    ),
                    TextFormField(
                      initialValue: _product.price == null
                          ? ''
                          : _product.price.toString(),
                      validator: (value) {
                        if (value.length == 0) {
                          return 'Value is required';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _product = Product(
                            description: _product.description,
                            id: _product.id,
                            imageUrl: _product.imageUrl,
                            price: double.parse(value),
                            title: _product.title,
                            isFavourite: _product.isFavourite);
                      },
                    ),
                    TextFormField(
                      initialValue: _product.description,
                      validator: (value) {
                        if (value.length == 0) {
                          return 'Value is required';
                        }
                        if (value.length < 0) {
                          return 'Value is too short';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _product = Product(
                            description: value,
                            id: _product.id,
                            imageUrl: _product.imageUrl,
                            price: _product.price,
                            title: _product.title,
                            isFavourite: _product.isFavourite);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration:
                                BoxDecoration(border: Border.all(width: 1)),
                            child: FittedBox(
                              child: _imgUrlcontroller.text != ''
                                  ? Image.network(
                                      _imgUrlcontroller.text,
                                      fit: BoxFit.cover,
                                    )
                                  : Text('Select Url'),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.length == 0) {
                                    return 'Value is required';
                                  }

                                  return null;
                                },
                                controller: _imgUrlcontroller,
                                decoration: InputDecoration(
                                  labelText: 'Image Url',
                                ),
                                onEditingComplete: () {
                                  FocusScope.of(context).unfocus();

                                  setUrl();
                                },
                                textInputAction: TextInputAction.done,
                                onSaved: (value) {
                                  _product = Product(
                                      description: _product.description,
                                      id: _product.id,
                                      imageUrl: value,
                                      price: _product.price,
                                      title: _product.title,
                                      isFavourite: _product.isFavourite);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
