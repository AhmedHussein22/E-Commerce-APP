import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/crud_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/all_products/ProductCard.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Allproducts extends StatefulWidget {
  @override
  _AllproductsState createState() => _AllproductsState();
}

class _AllproductsState extends State<Allproducts> {
   List<Product> products;

  @override
  Widget build(BuildContext context) {
   final productProvider = Provider.of<CRUDModel>(context);
    return Container(
      height: MediaQuery.of(context).size.height*0.33,
      child:  StreamBuilder(
          stream: productProvider.fetchProductsAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              products = snapshot.data.documents
                  .map((doc) => Product.fromMap(doc.data, doc.documentID))
                  .toList();
                   int length=(products.length~/2).toInt();
              return GridView.builder(
                itemCount: length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (buildContext, index) =>
                    ProductCard(productDetails: products[index]),
              );
            } else {
              return Loading();
            }
          },
        ),
    );
  }
}