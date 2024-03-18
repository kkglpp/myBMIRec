import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mybmirecord/Custom/textMiddle.dart';

class GridCard {
  Uint8List? imgBytes;
  final String recordDate;

  GridCard(this.imgBytes, this.recordDate);

  girdCard(double widthsize, double heightsize, double bmiValue,
      double paddingValue) {
    // double realWidth = widthsize;
    // double realHeight = heightsize ;
    double realWidth = widthsize - (paddingValue * 2);
    double realHeight = heightsize - (paddingValue * 2);
    return Padding(
      padding: EdgeInsets.all(paddingValue),
      child: SizedBox(
        width: realWidth,
        height: realHeight,
        child: Stack(
          children: [
            SizedBox(
              width: realWidth,
              height: realHeight,
            ),
            Positioned(
              child: Container(
                width: realWidth,
                height: realHeight,
                child: imgBytes == null
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        width: realWidth,
                        height: realHeight,
                        child: Center(
                          child: TextCustom().customText("No Image", 15, "C",
                              clr: Colors.white),
                        ),
                      )
                    : ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10), // 테두리의 둥글기 정도를 지정합니다

                        child: Image.memory(
                          imgBytes!,
                          fit: BoxFit.contain,
                        ),
                      ),
              ),
            ),
            Positioned(
              top: realHeight * 0.7,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
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
                                "BMI : ${bmiValue.toStringAsFixed(1)}", 8, "L"),
                            TextCustom().customText(recordDate, 10, "C"),
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
