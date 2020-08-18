import 'package:e_commerce/screens/login/login_screen.dart';
import 'package:e_commerce/screens/singup/singup.dart';
import 'package:flutter/material.dart';
class LginORSingUp extends StatefulWidget {
  @override
  _LginORSingUpState createState() => _LginORSingUpState();
}

class _LginORSingUpState extends State<LginORSingUp> {
  bool viweSignIn = false;
  void viewState()
  {
    setState(() => viweSignIn= !viweSignIn);
  }
  @override
  Widget build(BuildContext context) {
    if (viweSignIn==true)
    {
      return LoginScreen(viewstate:viewState);
    }
    else
    return SingUPScreen(viewstate:viewState);
  }
}