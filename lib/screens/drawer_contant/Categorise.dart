
import 'package:flutter/material.dart';

class Categoris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("All Categories"),
      ),
          body: ListView(
       scrollDirection: Axis.vertical,
       children: <Widget>[
         Category(
           imagePath: "assets/img/cate/mobile.png",
           categoryName:"Mobile"
         ),

          Category(
           imagePath: "assets/img/cate/shoes.png",
           categoryName:"Shoes"
         ),

          Category(
           imagePath: "assets/img/cate/accesories.png",
           categoryName:"Accesories"
         ),

          Category(
           imagePath: "assets/img/cate/clothes.png",
           categoryName:"Clothes"
         ),

          Category(
           imagePath: "assets/img/cate/makeup.png",
           categoryName:"Makeup"
         ),

          Category(
           imagePath: "assets/img/cate/books.png",
           categoryName:"Books"
         ),

          Category(
           imagePath: "assets/img/cate/electronics.png",
           categoryName:"Electronics"
         ),

          Category(
           imagePath: "assets/img/cate/sports.png",
           categoryName:"Sports"
         ),
       ],
),
    );

  }
}
class Category extends StatelessWidget {
  final String imagePath ;
  final String categoryName ;
  Category({this.imagePath,this.categoryName});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    return Padding(
      padding: const EdgeInsets.all(1),
          child: ListTile(

            onTap: (){
              if(categoryName=="Sports")
              {
                Navigator.pushNamed(context, "/SportsCategory");
              }
              if(categoryName=="Shoes")
              {
                Navigator.pushNamed(context, "/ShoseCategory");
              }
              if(categoryName=="Mobile")
              {
                Navigator.pushNamed(context, "/MobileCategory");
              }
              if(categoryName=="Accesories")
              {
                Navigator.pushNamed(context, "/AccesoriesCategory");
              }
              if(categoryName=="Clothes")
              {
                Navigator.pushNamed(context, "/ClothesCategory");
              }
              if(categoryName=="Makeup")
              {
                Navigator.pushNamed(context, "/MakeupCategory");
              }
              if(categoryName=="Books")
              {
                Navigator.pushNamed(context, "/BooksCategory");
              }
              if(categoryName=="Electronics")
              {
                Navigator.pushNamed(context, "/ElectronicsCategory");
              }
            },
            title:  CircleAvatar(
              backgroundColor: Color(0xFF0b0d34),
              radius: 100,
              child: Image.asset(imagePath,
               height: 90,
               width: 90,
              ),
            ),
            subtitle: Container(alignment: Alignment.topCenter,
            child:Text(categoryName,style: textStyle.copyWith(fontSize: 30),),
            )
          ),
    );
  }
}