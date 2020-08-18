import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color orange = Color(0xFFff8200);
Color blue = Color(0xFF0b0d34);

InputDecoration inputdecoration = InputDecoration(
  enabled: true,
  labelText: "Enter product name",
  labelStyle: TextStyle(
    color: blue,
    fontSize: 17,
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: orange),
  ),
   enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  
);
