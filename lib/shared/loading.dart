import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        
        child: SpinKitCircle(
          color: Theme.of(context).accentColor,
          size: 50.0,
          duration: Duration(seconds: 3),
          

        ),
      ),
    );
  }
}
