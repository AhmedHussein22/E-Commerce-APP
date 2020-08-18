import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() {
    return _IntroScreenState();
  }
}

class _IntroScreenState extends State<IntroScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: OverBoard(
       
        pages: pages(context),
        showBullets: true,
        
        finishCallback: () {
          Navigator.pushReplacementNamed(context, "/login");
        },

      ),
    );
  }
}

 pages(context){
final pages = [
  PageModel(
      color: const Color(0xFFff8200),
      imageAssetPath: 'assets/img/intro/1.png',
      title: 'Online Shopping',
      body: 'Share your fashion things with the people',
      doAnimateImage: true),
  PageModel(
      color: const Color(0xFF00beff),
      imageAssetPath: 'assets/img/intro/2.png',
      title: 'Buying',
      body: 'Buy every thing via our application',
      doAnimateImage: true),
  PageModel(
      color: const Color(0xFF0b0d34),
      imageAssetPath: 'assets/img/intro/3.png',
      title: 'Payment',
      body: 'pay your Bill online Without any problems and in a very safe way ',
      doAnimateImage: true),
  PageModel.withChild(
      child: Padding(
        padding: EdgeInsets.only(bottom: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Image.asset('assets/img/intro/4.png', width: 300.0, height: 300.0),
            Text("WELCOME" ,style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold)),
            Text("in our App", style: Theme.of(context).textTheme.subtitle1.copyWith(letterSpacing: 5,fontSize:17))
          ],
        ),
      ),
      color: const Color(0xFFff8200),
     
      doAnimateChild: true),
  
];
return pages;
 }