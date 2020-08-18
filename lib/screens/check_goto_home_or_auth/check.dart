import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/screens/check_goto_home_or_auth/login_or_singup.dart';
import 'package:e_commerce/screens/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Check extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user != null) {
      return HomePage();
    } else {
      return LginORSingUp();
    }
  }
}