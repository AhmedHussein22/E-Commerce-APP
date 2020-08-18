import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/crud_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/all_products/ProductCard.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MakeupCategory  extends StatefulWidget {
  @override
  _MakeupCategoryState createState() => _MakeupCategoryState();
}

class _MakeupCategoryState extends State<MakeupCategory> {
    List<Product> makeupCategory=[];
    List<Product> products;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Makeup",
      )),
      body: SafeArea(
        child: StreamBuilder(
          stream: productProvider.fetchProductsAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              products = snapshot.data.documents
                  .map((doc) => Product.fromMap(doc.data, doc.documentID))
                  .toList();
                  for (var i = 0; i < products.length; i++) {
                   // print(products[i].category);
                    if(products[i].category=="makeup")
                    {
                     // print("add 1");
                       makeupCategory.add(products[i]);
                   // print("sportsCategory$sportsCategory");
                    }
                  }
              return GridView.builder(
                itemCount: makeupCategory.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (buildContext, index) {
                    return  ProductCard(productDetails: makeupCategory[index]);

                  }

              );
            } else {
              return Loading();
            }
          },
        ),
      ),
    );
  }
}
