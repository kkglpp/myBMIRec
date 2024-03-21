import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RelativeSizeClass {
  double? widthSize;
  double? heightSize;
  double? customFontSizeS;
  double? customFontSizeM;
  double? customFontSizeL;
  double? customFontSizeXL;

  RelativeSizeClass(BuildContext context) {

    widthSize =  MediaQuery.of(context).size.width*0.9;
    heightSize =  MediaQuery.of(context).size.height*0.9-65;
    customFontSizeS = (widthSize! * 0.02).clamp(8, 12);  //450 기준 9
    customFontSizeM = (widthSize! * 0.02 *1.4).clamp(12, 20); // 450 기준 10.8
    customFontSizeL = (widthSize! * 0.02*1.4).clamp(14, 22) ; //450 기준 
    customFontSizeXL = (widthSize! * 0.02*0.4).clamp(18, 25);

  }
}