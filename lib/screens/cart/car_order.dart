import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/screens/cart/cart_card.dart';
import 'package:e_commerce/screens/cart/setting_form.dart';
import 'package:e_commerce/shared/drawer.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartdOrder extends StatefulWidget {
  @override
  _CartdOrderState createState() => _CartdOrderState();
}

class _CartdOrderState extends State<CartdOrder> {
  List<CartsModule> cartsModule;
  var price;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'My Cart',
        ),
      ),
      drawer: drawer(context),
      body: Column(
        children: [
          LayoutBuilder(builder: (context, constrains) {
            return Container(
              height: screenHeight -
                  statusBarHeight -
                  appBarHeight -
                  (screenHeight * .08),
              child: StreamBuilder<QuerySnapshot>(
                //stream: productProvider.fetchProductsAsStream(),
                stream: Firestore.instance
                    .collection('Cart')
                    .where("uid", isEqualTo: user.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    cartsModule = snapshot.data.documents
                        .map((doc) =>
                            CartsModule.fromMap(doc.data, doc.documentID))
                        .toList();
                    double totalPrice() {
                      double totalPrice = 0.0;
                      for (var i = 0; i < cartsModule.length; i++) {
                        totalPrice += cartsModule[i].price *
                            cartsModule[i].selectedquantity;
                      }
                      return totalPrice;
                    }
                    price = totalPrice();
                    if (cartsModule.isNotEmpty) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cartsModule.length,
                          itemBuilder: (buildContext, index) {
                            return CartCard(
                              productDetails: cartsModule[index],
                            );
                          });
                    } else {
                      return Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Theme.of(context).buttonColor,
                                size: 70,
                              ),
                              SizedBox(height: 10),
                              Text('Your Cart Is Empty',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontSize: 25)),
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
            );
          }),
          Builder(
            builder: (context) => ButtonTheme(
              minWidth: screenWidth,
              height: screenHeight * .08,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: theme.primaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: SettingForm(
                            productDetails: cartsModule,
                            totalprice: price,
                          ),

                        );
                      },

                      );
                },
                child: Text('Check Out',
                    style: theme.textTheme.subtitle1.copyWith(fontSize: 25)),
                color: theme.buttonColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
