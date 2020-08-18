import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/shared/toast.dart';
import 'package:flutter/material.dart';

class CartCard extends StatefulWidget {
  final CartsModule productDetails;
  CartCard({this.productDetails});
  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: theme.buttonColor,
        borderOnForeground: true,
        elevation: 5,
        margin: EdgeInsets.only(left: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: screenHeight * .13,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: screenHeight * .11 / 2,
                  backgroundImage: NetworkImage(widget.productDetails.urlimg),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.productDetails.name,
                              style: theme.textTheme.subtitle1
                                  .copyWith(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${widget.productDetails.price * widget.productDetails.selectedquantity} L.E',
                              style: theme.textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.productDetails.selectedquantity.toString(),
                              style: theme.textTheme.subtitle1,
                            )
                          ],
                        ),
                      ),
                     Builder(
                           builder: (context) => IconButton(
                            icon: Icon(
                              Icons.remove_shopping_cart,
                              color: theme.accentColor,
                            ),
                            onPressed: ()async {
                              showToast(context,"Deleted Successfully");
                              await Firestore.instance
                            .collection("Cart")
                            .document(widget.productDetails.id)
                            .delete();
                            },),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
