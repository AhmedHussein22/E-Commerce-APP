import 'dart:io';
import 'package:e_commerce/models/crud_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/shared/inputdecoration.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class EidtProduct extends StatefulWidget {
  final Product product;
  EidtProduct({this.product});
  @override
  _EidtProductState createState() => _EidtProductState();
}

class _EidtProductState extends State<EidtProduct> {
  final _key = GlobalKey<FormState>();
  String name;
  String category;
  double discount;
  double price;
  String _urlImg;
  String description;
  int quantity;
  String size;
  String color;
  List<String> listofcategories = [
    "mobile",
    "shoes",
    "accessories",
    "clothes",
    "makeup",
    "books",
    "electronics",
    "sport"
  ];
  File _image;
  bool isLoasing = false;
  final picker = ImagePicker();
  Future getImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
  }

  void uploadImage(context) async {
    try {
      final StorageReference storageRef =
          FirebaseStorage.instance.ref().child('products_mg');
      final StorageReference ref = storageRef.child(basename(_image.path));
      StorageUploadTask storageUploadTask = ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ),);
      print('url= $url');
      setState(
        () {
          _urlImg = url;
        },
      );
    } catch (ex) {
      print(ex.toString());
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(ex.message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final productProvider = Provider.of<CRUDModel>(context);
    ThemeData theme = Theme.of(context);
    return isLoasing
        ? Loading()
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Eidt by Admin"),
              ),
              body: Padding(
                padding: const EdgeInsets.only(right: 8, left: 15, top: 10),
                child: ListView(
                  children: [
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          //******************* name***********//
                          TextFormField(
                            initialValue: widget.product.name,
                            decoration: inputdecoration.copyWith(
                                labelText: "Enter Your new Product name"),
                            validator: (value) => value.isEmpty
                                ? "Pleas Enter Your new Product Name"
                                : null,
                            onSaved: (value) {
                              setState(() => name = value);
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          //*******************size***********//
                          TextFormField(
                            initialValue: widget.product.size,
                            decoration: inputdecoration.copyWith(
                                labelText: "Enter Your new Product size"),
                            validator: (value) => value.isEmpty
                                ? "Pleas Enter Your new Product size"
                                : null,
                            onSaved: (value) {
                              setState(() => size = value);
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          //*******************colors***********//
                          TextFormField(
                            initialValue: widget.product.color,
                            decoration: inputdecoration.copyWith(
                                labelText: "Enter Product colors available"),
                            validator: (value) => value.isEmpty
                                ? "Pleas Enter Your Product colors available"
                                : null,
                            onSaved: (value) {
                              setState(() => color = value);
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),

                          //*******************discount***********//
                          TextFormField(
                            initialValue: widget.product.discount.toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly,
                            ],
                            decoration: inputdecoration.copyWith(
                                labelText: "Enter new product discount"),
                            validator: (value) => (value.isEmpty)
                                ? "Pleas Enter new double value"
                                : null,
                            onSaved: (value) {
                              setState(() => discount = double.parse(value));
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          //*******************price***********//
                          TextFormField(
                            initialValue: widget.product.price.toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly,
                            ],
                            decoration: inputdecoration.copyWith(
                                labelText: "Enter new product price"),
                            validator: (value) => (value.isEmpty)
                                ? "Pleas Enter new double value"
                                : null,
                            onSaved: (value) {
                              setState(() => price = double.parse(value));
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          //*******************quantity***********//
                          TextFormField(
                            initialValue: widget.product.quantity.toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly,
                            ],
                            decoration: inputdecoration.copyWith(
                                labelText: "Enter new product quantity"),
                            validator: (value) => value.isEmpty
                                ? "Pleas  Enter new quantity "
                                : null,
                            onSaved: (value) {
                              setState(() => quantity = int.parse(value));
                            },
                            //*******************description***********//
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          TextFormField(
                            initialValue: widget.product.description,
                            decoration: inputdecoration.copyWith(
                                labelText: "Enter Your new description"),
                            validator: (value) => value.isEmpty
                                ? "Pleas Enter Your new description"
                                : null,
                            onSaved: (value) {
                              setState(() => description = value);
                            },
                          ),
                          //*******************category***********//
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                "Chose quantity",
                                style: theme.textTheme.subtitle1
                                    .copyWith(fontSize: 20),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.5),
                                child: Card(
                                  color: Color(0xFFff8200),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                      value:  category,

                                      isExpanded: true,
                                      style: theme.textTheme.subtitle1,
                                      elevation: 5,
                                      focusColor: Color(0xFFff8200),
                                      dropdownColor: Color(0xFFff8200),
                                      underline: Container(
                                        color: Colors.transparent,
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                      onChanged: (newvalue) {
                                        setState(() {
                                          category = newvalue;
                                        });
                                      },
                                      items: listofcategories.map((quan) {
                                        return DropdownMenuItem(
                                        
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25),
                                            margin: EdgeInsets.only(
                                                right: 8, left: 8),
                                            child: Text(
                                              quan.toString(),
                                              style: theme.textTheme.subtitle1,
                                            ),
                                          ),
                                          value: quan,
                                        );
                                      }).toList()),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          //*******************add image***********//
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                  color: theme.accentColor, width: 2),
                              onPressed: () {
                                getImage();
                              },
                              child: _image == null
                                  ? Image.network(widget.product.urlimg)
                                  : Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Builder(
                            builder: (context) => RaisedButton(
                              onPressed: () {
                                uploadImage(context);
                              },
                              elevation: 10,
                              child: Text(
                                "Upload this new image",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(fontSize: 20),
                              ),
                              color: Theme.of(context).buttonColor,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          //*******************upload to firebase***********//
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: RaisedButton(
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                         setState(() => isLoasing=true);
                        _key.currentState.save();
                         await productProvider.updateProduct(
                          Product(
                            name: name,
                            category: category,
                            description: description,
                            discount: discount,
                            price: price,
                            quantity: quantity,
                            urlimg: _urlImg,
                            color: color,
                            size: size,
                          ),
                          widget.product.id,
                        );
                        Navigator.pop(context);
                      }
                    },
                    elevation: 10,
                    child: Text(
                      "Upload Product",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontSize: 20),
                    ),
                    color: Theme.of(context).buttonColor,
                  ),
                ),
                 SizedBox(
                  height: height * 0.04,
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
