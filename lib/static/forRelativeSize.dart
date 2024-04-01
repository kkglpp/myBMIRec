import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RelativeSizeClass {

  double? widthSize;
  double? heightSize;
  double? customFontSizeS;
  double? customFontSizeM;
  double? customFontSizeL;
  double? customFontSizeXL;
  var  orientation ;
  RelativeSizeClass(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    widthSize =  400.w;
    heightSize =  750.h;
    customFontSizeS = 10.sp;
    customFontSizeM = 13.sp;
    customFontSizeL = 17.sp;
    customFontSizeXL = 21.sp;
    /* screenUtil 안쓸떄 썻던 방법. */
    // orientation = MediaQuery.of(context).orientation;
    // widthSize =  MediaQuery.of(context).size.width*0.9;
    // heightSize =  MediaQuery.of(context).size.height*0.9-65;// 통상적인 app 바의 높이. 
    // customFontSizeS = (widthSize! * 0.02).clamp(8, 12);  //450 기준 9
    // customFontSizeM = (widthSize! * 0.02 *1.4).clamp(10, 20); // 450 기준 12.6
    // customFontSizeL = (widthSize! * 0.02*1.6).clamp(14, 22) ; //450 기준 14.4
    // customFontSizeXL = (widthSize! * 0.02*2).clamp(18, 25); //450 -> 18
  }
}