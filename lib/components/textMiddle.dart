
import 'package:flutter/material.dart';

class TextCustom {
  customText(String msg, double fSize, String alig, {Color clr = Colors.black}){
    return Text(
      msg,
      textAlign: alig=="L"? TextAlign.left : alig=="C"? TextAlign.center: TextAlign.right,
      style: TextStyle(
        color: clr,
        fontSize: fSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}