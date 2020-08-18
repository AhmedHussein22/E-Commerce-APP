import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

void showToast(context,String msg,) {
  ThemeData theme=Theme.of(context);

    Toast.show(
      msg,
      context,
      duration: Toast.LENGTH_SHORT,
       gravity: Toast.BOTTOM,
       backgroundRadius: 15.0,
       border: Border.all(
         color: Colors.white,
         width: 2,
       ),
       backgroundColor: theme.buttonColor,
       textColor: Colors.white,

      );
  }