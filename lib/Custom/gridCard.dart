import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mybmirecord/Custom/textcustom.dart';

class GridCard {
  Uint8List? imgBytes;
  final String recordDate;


  GridCard(this.imgBytes, this.recordDate, );

  girdCard(double widthsize, double heightsize, double bmiValue,
      double paddingValue, {double fsize = 12}) {
    // double realWidth = widthsize;
    // double realHeight = heightsize ;

    late double lenSize = min(widthsize,heightsize);
    double realWidth = lenSize - (paddingValue * 2);
    double realHeight = lenSize - (paddingValue * 2);
    return Padding(
      padding: EdgeInsets.all(paddingValue),
      child: SizedBox(
        width: realWidth,
        height: realHeight,
        child: Stack(
          children: [
            Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
              width: realWidth,
              height: realHeight,
            ),
            Positioned(
              child: imgBytes == null
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      width: realWidth,
                      height: realHeight,
                      child: Center(
                        child: TextCustom().customText("No Image", fsize*1.5, "C",
                            clr: Colors.white),
                      ),
                    )
                  : Container(
                                            decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10), // 테두리의 둥글기 정도를 지정합니다
                    
                        child: Image.memory(
                          imgBytes!,
                          width: realWidth,
                          fit: BoxFit.fill,
                        ),
                      ),
                  ),
            ),
            Positioned(
              top: realHeight * 0.7,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withAlpha(190),
                      // color: Colors.white.withAlpha(180),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  width: realWidth,
                  height: realHeight * 0.3,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom().customText(
                                "BMI : ${bmiValue.toStringAsFixed(1)}", fsize, "L"),
                            TextCustom().customText(recordDate, fsize*0.9, "C"),
                          ]),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
