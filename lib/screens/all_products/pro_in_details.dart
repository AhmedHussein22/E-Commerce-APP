import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/crud_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/screens/admin_side/eidt_product.dart';
import 'package:e_commerce/screens/cart/setting_form.dart';
import 'package:e_commerce/services/cart.dart';
import 'package:e_commerce/services/favourites.dart';
import 'package:e_commerce/shared/loading.dart';
import 'package:e_commerce/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProInDetalis extends StatefulWidget {
  final Product product;

  ProInDetalis({@required this.product});

  @override
  _ProInDetalisState createState() => _ProInDetalisState();
}

class _ProInDetalisState extends State<ProInDetalis> {
  List <dynamic>productlist =[];
  bool isFavorite = false;
  int selectedquan = 1;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);
    final user = Provider.of<User>(context);
    ThemeData theme = Theme.of(context);
    var newPrice= widget.product.price *(1 - (widget.product.discount)/100);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        centerTitle: false,
        actions: user.email.contains("edu")
            ? <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () async {
                        await productProvider.removeProduct(widget.product.id);
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.delete_forever),
                    )),
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EidtProduct(
                                      product: widget.product,
                                    )));
                      },
                      child: Icon(
                        Icons.edit,
                      ),
                    )),
              ]
            : null,
      ),
      body: ListView(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.product.urlimg,
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
                placeholder: (context, url) => new Loading(),
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Chose quantity",
                      style: theme.textTheme.subtitle1.copyWith(fontSize: 20),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.5),
                      child: Card(
                        color: Color(0xFFff8200),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton(
                            isExpanded: true,
                            value: selectedquan,
                            style: theme.textTheme.subtitle1,
                            elevation: 5,
                            focusColor: Color(0xFFff8200),
                            dropdownColor: Color(0xFFff8200),
                            underline: Container(
                              color: Colors.transparent,
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedquan = value;
                              });
                            },
                            items: listofquanFun(widget.product.quantity)
                                .map((quan) {
                              return DropdownMenuItem(
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.25),
                                  margin: EdgeInsets.only(right: 8, left: 8),
                                  child: Text(
                                    quan.toString(),
                                    style: theme.textTheme.subtitle1,
                                  ),
                                ),
                                value: quan,
                              );
                            }).toList()),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    ButtonTheme(
                      buttonColor: Color(0xFFff8200),
                      minWidth: MediaQuery.of(context).size.width * 0.65,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: RaisedButton(
                        onPressed: () {
                          var price = selectedquan * newPrice;
                           productlist.add(widget.product);
                          showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: theme.primaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: SettingForm(
                            productDetails: productlist,
                            totalprice: price,
                          ),

                        );
                      },
                      );
                      productlist.clear();
                        },
                        elevation: 5,
                        child: Text(
                          "Buy Now (${selectedquan * newPrice} L.E)",
                          style: theme.textTheme.subtitle1,
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () async{
                            await CartDB(uid: user.uid).addCart(
                             user.uid ,
                             widget.product.name,
                             newPrice,
                             widget.product.urlimg,
                                selectedquan,
                              );
                              showToast(context, "Added Successfully");
                            }
                          ),
                    ),
                    IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                        ),
                        onPressed: ()async {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                          await Favourites(uid: user.uid).addfavourites(
                            user.uid,
                            widget.product.name,
                             newPrice,
                              widget.product.urlimg,
                               widget.product.discount,
                            );
                        })
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          //****************description***************//
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: ("description : "),
                    style: theme.textTheme.headline6,
                    children: <TextSpan>[
                      TextSpan(
                        text: "${widget.product.description}",
                        style: theme.textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
                Divider(),
                //****************available quantity***************//
                RichText(
                  text: TextSpan(
                    text: ("available quantity : "),
                    style: theme.textTheme.headline6,
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.product.quantity.toString(),
                        style: theme.textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
                Divider(),
                RichText(
                  text: TextSpan(
                    text: ("available size: "),
                    style: theme.textTheme.headline6,
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.product.size,
                        style: theme.textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
                Divider(),
                RichText(
                  text: TextSpan(
                    text: ("available colors: "),
                    style: theme.textTheme.headline6,
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.product.color.toString(),
                        style: theme.textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
                Divider(),
                RichText(
                  text: TextSpan(
                    text: ("name : "),
                    style: theme.textTheme.headline6,
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.product.name,
                        style: theme.textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
                Divider(),
                RichText(
                  text: TextSpan(
                    text: ("discount : "),
                    style: theme.textTheme.headline6,
                    children: <TextSpan>[
                      TextSpan(
                        text: "${widget.product.discount.toString()}%",
                        style: theme.textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
                Divider(),
                RichText(
                  text: TextSpan(
                    text: ("Price : "),
                    style: theme.textTheme.headline6,
                    children: <TextSpan>[
                      TextSpan(
                        text: "${newPrice.toString()} L.E",
                        style: theme.textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
                Divider(),
//                Text(cate),
//                SimilarProducts(index: widget.index,cate: cate,),
              ],
            ),
          )
        ],
      ),
    );
  }
}

List listofquanFun(availableQuantity) {
  List<int> listofquan = [];
  for (int i = 1; i <= availableQuantity; i++) {
    listofquan.add(i);
  }
  return listofquan;
}
