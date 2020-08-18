import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/crud_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/all_products/ProductCard.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ElectronicsCategory  extends StatefulWidget {
  @override
  _ElectronicsCategoryState createState() => _ElectronicsCategoryState();
}

class _ElectronicsCategoryState extends State<ElectronicsCategory> {
    List<Product> electronicsCategory=[];
    List<Product> products;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Electronics",
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
                    if(products[i].category=="electronics")
                    {
                     // print("add 1");
                       electronicsCategory.add(products[i]);
                   // print("sportsCategory$sportsCategory");
                    }
                  }
              return GridView.builder(
                itemCount: electronicsCategory.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (buildContext, index) {
                    return  ProductCard(productDetails: electronicsCategory[index]);

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
