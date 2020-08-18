import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/crud_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/all_products/ProductCard.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClothesCategory  extends StatefulWidget {
  @override
  _ClothesCategoryState createState() => _ClothesCategoryState();
}

class _ClothesCategoryState extends State<ClothesCategory> {
    List<Product> clothesCategory=[];
    List<Product> products;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Clothes",
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
                    if(products[i].category=="clothes")
                    {
                     // print("add 1");
                       clothesCategory.add(products[i]);
                   // print("sportsCategory$sportsCategory");
                    }
                  }
              return GridView.builder(
                itemCount: clothesCategory.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (buildContext, index) {
                    return  ProductCard(productDetails: clothesCategory[index]);

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
