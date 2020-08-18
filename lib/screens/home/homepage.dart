import 'package:e_commerce/screens/home/carousel_imgs.dart';
import 'package:e_commerce/screens/home/categoris.dart';
import 'package:e_commerce/screens/home/products.dart';
import 'package:e_commerce/shared/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  Widget build(BuildContext context) {
     TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("E shoppers",
          ),
          actions: <Widget>[
            IconButton(
              icon:Icon(Icons.favorite,) ,
                onPressed: (){
                  Navigator.of(context).pushNamed("/FavouritesOrders");
                },
                ),
              IconButton(
              icon:Icon(Icons.shopping_cart) ,
                onPressed: (){
                  Navigator.of(context).pushNamed("/CartdOrder");
                },
                ),
          ],
        ),
        drawer: drawer(context),
        body: ListView (
          children: <Widget>[
            carouselImgs(context),
            Padding(
              padding: const EdgeInsets.only(top: 3, left:10),
              child: Text("Categoris", style: textStyle,)
            ),
            Categoris(),
            SizedBox(height:4),
            Divider(

          ),
            
               Padding(
                  padding:const EdgeInsets.only(top: 3, left:3) ,
                 child: Container(
                   //alignment: Alignment.topRight,
                   child: Row(
                     children: [
                       Text("Recent products",style: textStyle.copyWith(fontSize: 20),),
                       SizedBox(width: MediaQuery.of(context).size.width*0.20,),
                       FlatButton(
                        onPressed: (){
                          Navigator.pushNamed(context, "/MainAllProducts");
                        },
                         child:Row(
                           children: [
                             Text ("All Products", style: textStyle.copyWith(fontSize: 20,color: Colors.white),),
                             Icon(Icons.arrow_forward,color: Colors.white,)
                           ],
                         ),
                        ),
                      //
                     ],
                   ),
            ),
                 ),
            Allproducts(),

          ],

        ),
      ),
    );
  }
}