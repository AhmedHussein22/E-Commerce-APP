import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

Widget carouselImgs (context){
  Color orange = Color(0xFFff8200);
  Color white = Colors.white;
  return Container(
    
    height: MediaQuery.of(context).size.height*0.3,
    
    child: Carousel(
      images: [
        AssetImage("assets/img/carousel_img/1.png"),
        AssetImage("assets/img/carousel_img/2.jpg"),
        AssetImage("assets/img/carousel_img/3.jpg"),
        AssetImage("assets/img/carousel_img/4.jpg"),
        AssetImage("assets/img/carousel_img/5.jpg"),
        AssetImage("assets/img/carousel_img/6.jpg"),
        AssetImage("assets/img/carousel_img/7.jpg"),
        
      ],
      dotSize: 4.0,
      dotSpacing: 15.0,
      dotColor: white,
      indicatorBgPadding: 5.0,
      dotBgColor:Colors.transparent,
      borderRadius: false,
      noRadiusForIndicator: true,
      overlayShadow: true,
      overlayShadowColors: orange,
      overlayShadowSize: 1,
      autoplay: true,
      boxFit: BoxFit.cover,
      autoplayDuration: Duration(seconds: 6),
      animationCurve:Curves.fastOutSlowIn,
      animationDuration: Duration(seconds:5),
      
    ),
  );
}