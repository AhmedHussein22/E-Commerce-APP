import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData themeData(){
  Color blue = Color(0xFF0b0d34);
  Color skyBlue = Color(0xFF00beff);
  Color orange = Color(0xFFff8200);
  Color white = Colors.white;
  return ThemeData(
    splashColor: skyBlue,
    accentColor: blue,
    canvasColor: skyBlue,
    scaffoldBackgroundColor: skyBlue,
    dividerColor: white,
    primaryColor: skyBlue,
    buttonColor: orange,
    //app bar theme
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: white,size: 30),
      color: orange,
      brightness: Brightness.light,
      centerTitle: true,
      elevation: 5,
      actionsIconTheme: IconThemeData(
        color: blue,
        size: 30,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: white,
          fontSize: 30,
          fontFamily: "Chewy"
        ),
      ),
    ),
    //iconTheme
    iconTheme: IconThemeData(
      color: white,
      size: 30
    ),
    textTheme: TextTheme(
      subtitle1: TextStyle(color: white, fontSize:14, fontWeight: FontWeight.bold),
      headline6:TextStyle(color:blue, fontFamily: "Chewy",fontSize: 25) ,
      headline1: TextStyle(color: blue, fontSize:15, fontWeight: FontWeight.bold,),
      headline2: TextStyle(color: blue, fontSize:17,),
      headline3: TextStyle(color:orange, fontSize:20, fontWeight: FontWeight.bold)
    ),
    cardTheme: CardTheme(
      elevation: 5,
      shadowColor: blue,
    //  shape: Border.all(color: blue,width: 2),

    ),

    dividerTheme: DividerThemeData(
      thickness: 1,
      endIndent: 10.0,
      indent: 10.0,
    ),
    buttonTheme: ButtonThemeData(
      height: 25,
      splashColor: blue,
    ),

    

    
    
  );
}