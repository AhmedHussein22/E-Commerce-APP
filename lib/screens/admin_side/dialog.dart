import 'package:e_commerce/screens/admin_side/add_new_product.dart';
import 'package:e_commerce/screens/all_products/main_all_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget alertDialog(context) {
  return Center(
      child: Container(
    color: Color(0Xff000725),
    child: AlertDialog(
      backgroundColor: Color(0XFFff2fc3),
      title: Text(
        "You Added Your Product",
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          color: Colors.white,
          fontSize: 21,
        ),
      ),
      content: Text(
        "Do you want add new Product agine or back to home ?",
        style: TextStyle(
          color: Color(0Xff000725),
          fontSize: 16,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNewProdcts()));
          },
          child: Text(
            "Add Product",
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainAllProducts()));
          },
          child: Text(
            "All Products",
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
            ),
          ),
        ),
      ],
    ),
  ),
  );
}
