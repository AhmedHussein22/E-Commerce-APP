import 'dart:io';
import 'package:e_commerce/models/crud_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AddNewProdcts extends StatefulWidget {
  @override
  _AddNewProdctsState createState() => _AddNewProdctsState();
}

class _AddNewProdctsState extends State<AddNewProdcts> {
   final _key = GlobalKey<FormState>();
    String name;
    String category;
    double discount;
    double price;
    String _urlImg;
    String description;
    int quantity;
    String size ;
    String color;
    List<String> listofcategories= ["mobile","shoes","accessories","clothes","makeup","books","electronics","sport"];
    File _image;
    bool isLoasing= false;
    final picker = ImagePicker();
  Future getImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image=File(image.path);
    });

  }
 void uploadImage(context) async {
    try {
      final StorageReference storageRef = FirebaseStorage.instance.ref().child('products_mg');
      final StorageReference ref = storageRef.child(basename(_image.path));
      StorageUploadTask storageUploadTask = ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
       Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));
      print('url= $url');
      setState(() {
        _urlImg = url;
      },
      );
    } catch (ex) {
     print(ex.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
    final width =MediaQuery.of(context).size.width;
    final productProvider = Provider.of<CRUDModel>(context);
    ThemeData theme=Theme.of(context);
    return isLoasing ?Loading(): SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:Text("AddNewProdcts by Admin"),

        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 8,left:15,top: 10),
          child: ListView(
            children: [
              Form(
            key: _key,
            child: Column(
              children: [

                //******************* name***********//
                TextFormField(
                      
                  decoration: InputDecoration(

                      labelText: "Enter product name",
                      labelStyle: theme.textTheme.headline2,
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.buttonColor),
                       ),
                      ),
                  validator: (value) =>
                      value.isEmpty ? "Pleas Enter Your Product Name" : null,
                  onChanged: (value) {
                    setState(() => name = value);
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                //*******************size***********//
                TextFormField(

                  decoration: InputDecoration(

                      labelText: "Enter product size",
                      labelStyle: theme.textTheme.headline2,
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.buttonColor),
                       ),
                      ),
                  validator: (value) =>
                      value.isEmpty ? "Pleas Enter Your Product size" : null,
                  onChanged: (value) {
                    setState(() => size = value);
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                //*******************colors***********//
                TextFormField(

                  decoration: InputDecoration(

                      labelText: "Enter Product colors available",
                      labelStyle: theme.textTheme.headline2,
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.buttonColor),
                       ),
                      ),
                  validator: (value) =>
                      value.isEmpty ? "Pleas Enter Your Product colors available" : null,
                  onChanged: (value) {
                    setState(() => color = value);
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),

                //*******************discount***********//
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp("[0-9.]")),
                  ],

                  decoration: InputDecoration(

                      labelText: "Enter product discount",
                      labelStyle: theme.textTheme.headline2,
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.buttonColor),
                       ),
                      ),
                  validator: (value) =>
                      (value.isEmpty) ? "Pleas Enter double value" : null,
                  onChanged: (value) {
                    setState(() => discount = double.parse(value));
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                //*******************price***********//
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp("[0-9.]")),
                  ],
                  
                 decoration: InputDecoration(
                    
                      labelText: "Enter product price",
                      labelStyle: theme.textTheme.headline2,
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.buttonColor),
                       ),
                      ),
                  validator: (value) =>
                     (value.isEmpty) ? "Pleas Enter double value" : null,
                  onChanged: (value) {
                    setState(() => price = double.parse(value));
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                //*******************quantity***********//
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    
                      labelText: "Enter product quantity",
                      labelStyle: theme.textTheme.headline2,
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.buttonColor),
                       ),
                      ),
                  validator: (value) =>
                      value.isEmpty ? "Pleas Enter quantity " : null,
                  onChanged: (value) {
                    setState(() => quantity = int.parse(value));
                  },
                  //*******************description***********//
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                TextFormField(

                  decoration: InputDecoration(

                      labelText: "Enter product description",
                      labelStyle: theme.textTheme.headline2,
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.buttonColor),
                       ),

                      ),
                  validator: (value) =>
                      value.isEmpty ? "Pleas Enter Your description" : null,
                  onChanged: (value) {
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
                        style: theme.textTheme.subtitle1.copyWith(fontSize: 20),
                      ),
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.5),
                        child: Card(
                          color: Color(0xFFff8200),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                               value: category,
                               hint: Text("Choose a category"),
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
                              onChanged: (value) {
                                setState(() {
                                  category = value;
                                });
                              },
                              items: listofcategories.map((quan) {
                                return DropdownMenuItem(
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.25),
                                    margin: EdgeInsets.only(right: 8, left: 8),
                                    child: Text(
                                      quan.toString(),
                                      style: theme.textTheme.subtitle1,
                                    ),
                                  ),
                                  value: quan,
                                );
                              }).toList()
                        ),
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
                     borderSide: BorderSide(color:theme.accentColor, width:2),
                     onPressed: (){
                       getImage();
                     },
                     child: _image==null?  Container(
                       width: width,
                       height: height*0.3,
                       child: new Icon(Icons.add_a_photo, color: Colors.white,),
                       ):Image.file(_image, fit: BoxFit.cover,),
                   ),
                 ),
                  SizedBox(
                  height: height * 0.04,
                ),
                Builder(
                    builder: (context) => ButtonTheme(
                       minWidth: MediaQuery.of(context).size.width * 0.3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                                          child: RaisedButton(
                      onPressed: () {
                        uploadImage(context);
                      },
                   elevation: 10,
                        child: Text(
                          "Upload this image",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontSize: 20),
                        ),
                        color: Theme.of(context).buttonColor,
                      ),
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
                        await productProvider.addProduct(
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
                            isfavourites: false,
                          )
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