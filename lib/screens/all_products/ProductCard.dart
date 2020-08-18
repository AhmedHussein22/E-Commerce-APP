import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/all_products/pro_in_details.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product productDetails;
  ProductCard({this.productDetails});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var newPrice = widget.productDetails.price *
        (1 - (widget.productDetails.discount) / 100);
    ThemeData theme = Theme.of(context);
    //newPrice = oldPrice(1-discount/100);
    return Card(
      child: Hero(
          tag: widget.productDetails.id,
          child: Material(
            animationDuration: Duration(seconds: 2),
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ProInDetalis(product: widget.productDetails))),
              child: GridTile(
                  header: (widget.productDetails.discount) != 0.0
                      ? Container(
                          child: Text(
                            "${widget.productDetails.discount} % free",
                            style: theme.textTheme.headline1
                                .copyWith(backgroundColor: Colors.red),
                          ),
                        )
                      : null,
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
                                  text: (widget.productDetails.discount) !=
                                          0.0
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
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error_outline),
                    placeholder: (context, url) => new Loading(),
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
