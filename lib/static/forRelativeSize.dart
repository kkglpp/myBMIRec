import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RelativeSizeClass {
  double? widthSize;
  double? heightSize;
  double? customFontSizeS;
  double? customFontSizeM;
  double? customFontSizeL;

  RelativeSizeClass(BuildContext context) {
    widthSize = ResponsiveValue(
      context,
      conditionalValues: [
        const Condition.equals(name: MOBILE, value: 200.0),
        const Condition.equals(name: TABLET, value: 220.0),
        const Condition.equals(name: '2K', value: 250.0),
        const Condition.equals(name: '4K', value: 300.0),
      ],
    ).value;
    heightSize = ResponsiveValue(
      context,
      conditionalValues: [
        const Condition.equals(name: MOBILE, value: 200.0),
        const Condition.equals(name: TABLET, value: 220.0),
        const Condition.equals(name: '2K', value: 250.0),
        const Condition.equals(name: '4K', value: 300.0),
      ],
    ).value;
    customFontSizeS = ResponsiveValue(
      context,
      conditionalValues: [
        const Condition.equals(name: MOBILE, value: 200.0),
        const Condition.equals(name: TABLET, value: 220.0),
        const Condition.equals(name: '2K', value: 250.0),
        const Condition.equals(name: '4K', value: 300.0),
      ],
    ).value;
    customFontSizeM = ResponsiveValue(
      context,
      conditionalValues: [
        const Condition.equals(name: MOBILE, value: 200.0),
        const Condition.equals(name: TABLET, value: 220.0),
        const Condition.equals(name: '2K', value: 250.0),
        const Condition.equals(name: '4K', value: 300.0),
      ],
    ).value;
    customFontSizeL = ResponsiveValue(
      context,
      conditionalValues: [
        const Condition.equals(name: MOBILE, value: 200.0),
        const Condition.equals(name: TABLET, value: 220.0),
        const Condition.equals(name: '2K', value: 250.0),
        const Condition.equals(name: '4K', value: 300.0),
      ],
    ).value;




    
  }
}