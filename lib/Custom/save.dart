import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mybmirecord/Custom/textMiddle.dart';

class GridCard {
  Uint8List? imgBytes;
  final String recordDate;

  GridCard(this.imgBytes, this.recordDate);

  girdCard(double widthsize, double heightsize, double bmiValue, double paddingValue) {
    double realWidth = widthsize;
    double realHeight = heightsize ;
    // double realWidth = widthsize - (paddingValue * 2);
    // double realHeight = heightsize - (paddingValue * 2);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      width: realWidth,
      height: realHeight,
      child: Stack(
        children: [
          Container(
            width: realWidth,
            height: realHeight,
          ),

          Positioned(
            child:           imgBytes == null
            ? ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // 테두리의 둥글기 정도를 지정합니다
                child: Image.asset(
                  "images/0.jpeg",
                  fit: BoxFit.contain,
                ),
              )
            : ClipRRect(
                borderRadius:
                    BorderRadius.circular(20), // 테두리의 둥글기 정도를 지정합니다
              
                child: Image.memory(
                  imgBytes!,
                  fit: BoxFit.contain,
                ),
              ),
          ),

    
          Positioned(
            top: realHeight * 0.8,
            child: Container(
                decoration: BoxDecoration(
                color: Colors.grey.withAlpha(220),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                ),
                width: realWidth,
                height: realHeight * 0.2,
                child: Center(
                  child: TextCustom().customText(recordDate, 10, "c"),
                )),
          ),
          // Positioned(
          //   top: realHeight * 0.6,
          //   child: Container(
          //       decoration: BoxDecoration(
          //       color: Colors.white.withAlpha(220),
          //         // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
          //       ),
          //       width: realWidth,
          //       height: realHeight * 0.2,
          //       child: Center(
          //         // child: TextCustom().customText("BMI : ${bmiValue.toStringAsFixed(1)}", 4, "c"),
          //       ),),
          // ),
        ],
      ),
    );
  }
}
