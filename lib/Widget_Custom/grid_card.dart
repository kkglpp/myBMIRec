import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mybmirecord/Widget_Custom/custom_widget.dart';

class GridCard {
  Uint8List? imgBytes;
  final String recordDate;

  GridCard(
    this.imgBytes,
    this.recordDate,
  );

  CustomWidget cWidget = CustomWidget();

  girdCard(
      double widthsize, double heightsize, double bmiValue, double paddingValue,
      {double fsize = 12}) {


    late double lenSize = min(widthsize, heightsize);
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
                // color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  //그림자를 넣어서 꾸민다.
                  //BMI 수치에따라 색을 바꿔준다.
                  // 저체중 (18.5 미만) - 보라색   정상체중 (30 미만) - 파랑색   과체중~~ - 붉은색
                  // 수치별 색은 시각화 시킨 원의 범위별 색과 일치.

                  BoxShadow(
                    color: bmiValue < 18.5
                        ? Colors.purple
                        : bmiValue < 30
                            ? Colors.blue
                            : Colors.red,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
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
                        child: cWidget.customText("No Image", fsize * 1.2, "C",
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
              top: realHeight * 0.65,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withAlpha(190),
                      // color: Colors.white.withAlpha(180),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  width: realWidth,
                  height: realHeight * 0.35,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cWidget.customText("BMI : ${bmiValue.toStringAsFixed(1)}",
                                fsize, "L"),
                            cWidget.customText(recordDate, fsize * 0.6, "C"),
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
