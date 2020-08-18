import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/favorites_model.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:e_commerce/shared/toast.dart';
import 'package:flutter/material.dart';

class FavouritesCard extends StatefulWidget {
  final FavoritesModule productDetails;
  FavouritesCard({this.productDetails});

  @override
  _FavouritesCardState createState() => _FavouritesCardState();
}

class _FavouritesCardState extends State<FavouritesCard> {
  @override
  Widget build(BuildContext context) {
    var newPrice = widget.productDetails.price *
        (1 - (widget.productDetails.discount) / 100);
    ThemeData theme = Theme.of(context);
    //newPrice = oldPrice(1-discount/100);
    return Card(
      child: Hero(
        tag: widget.productDetails.id,
        child: GridTile(
            header: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.productDetails.discount) != 0.0
                    ? Container(
                        child: Text(
                          "${widget.productDetails.discount} % free",
                          style: theme.textTheme.headline1
                              .copyWith(backgroundColor: Colors.red),
                        ),
                      )
                    : null,
                SizedBox(
                  height: 0.0,
                  width: (MediaQuery.of(context).size.width / 7.5),
                ),
               Builder(
                           builder: (context) => IconButton(
                      alignment: Alignment.topRight,
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        showToast(context,"Deleted Successfully");
                         await Firestore.instance
                            .collection("Favourites")
                            .document(widget.productDetails.id)
                            .delete();
                           
                      }),
                )
              ],
            ),
            footer: Container(
                color: Color(0x5500beff),
                child: Column(
                  children: <Widget>[
                    Text(widget.productDetails.name,
                        style: theme.textTheme.headline1),
                    RichText(
                      text: TextSpan(
                        text: ("${newPrice.toString()} L.E  "),
                        style: theme.textTheme.headline1.copyWith(
                          color: Color(0xFFff8200),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: (widget.productDetails.discount) != 0.0
                                ? ("${widget.productDetails.price} L.E")
                                : null,
                            style: theme.textTheme.headline1.copyWith(
                                color: Colors.white,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                decorationThickness: 2),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            child: CachedNetworkImage(
              imageUrl: widget.productDetails.urlimg,
              errorWidget: (context, url, error) => Icon(Icons.error_outline),
              placeholder: (context, url) => new Loading(),
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
