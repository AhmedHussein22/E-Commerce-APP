import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/favorites_model.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/screens/drawer_contant/favourites/favourites_card.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesOrders extends StatefulWidget {
  @override
  _FavouritesOrdersState createState() => _FavouritesOrdersState();
}

class _FavouritesOrdersState extends State<FavouritesOrders> {
  List<FavoritesModule> favoritesModule;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favourites",)
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          //stream: productProvider.fetchProductsAsStream(),
          stream: Firestore.instance
                  .collection('Favourites')
                  .where("uid", isEqualTo: user.uid)
                  .snapshots(),
              
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              favoritesModule = snapshot.data.documents
                  .map((doc) => FavoritesModule.fromMap(doc.data, doc.documentID))
                  .toList();
              if (favoritesModule.isNotEmpty) {
                return GridView.builder(
                itemCount: favoritesModule.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (buildContext, index) {

                  return FavouritesCard(productDetails: favoritesModule[index],);

                }
              );
              } else {return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                      color: Theme.of(context).buttonColor,
                      size: 70,
                      ),
                      SizedBox(height:10),
                      Text('Favourites List Is Empty',
                      style:Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 25)
                      ),
                    ],
                  ),
                ),
              );

              }
            } else {
              return Loading();
            }
          },
        ),
      ),
      
    );
  }
}