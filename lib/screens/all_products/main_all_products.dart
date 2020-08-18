import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/shared/drawer.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/screens/all_products/ProductCard.dart';

class MainAllProducts extends StatefulWidget {
  @override
  _MainAllProductsState createState() => _MainAllProductsState();
}

class _MainAllProductsState extends State<MainAllProducts> {
  List<Product> products;
  String searchText="";
  bool isSearch = false;
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: user.email.contains("edu")
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, "/AddNewProdcts");
              },
              backgroundColor: theme.buttonColor,
              elevation: 5,
              child: Icon(
                Icons.add_circle_outline,
                color: theme.accentColor,
              ),
            )
          : null,
      appBar: AppBar(
        title: !isSearch
            ? Text(
                "All Products",
              )
            : TextField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Full Product Name"),
                    onChanged: (text){
                      setState(() {
                        searchText=text;
                      });
                    },
              ),
        actions: <Widget>[
          !isSearch
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearch = !isSearch;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      isSearch = !isSearch;
                      searchText="";
                    });
                  },
                ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed("/CartdOrder");
            },
          ),
        ],
      ),
      drawer: drawer(context),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: searchText != "" && searchText != null
              ? Firestore.instance
                  .collection('products')
                  .where("name", isEqualTo: searchText)
                  .snapshots()
              : Firestore.instance.collection("products").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              products = snapshot.data.documents
                  .map((doc) => Product.fromMap(doc.data, doc.documentID))
                  .toList();
              return GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (buildContext, index) {

                  return ProductCard(productDetails: products[index]);

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
