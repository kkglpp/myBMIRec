import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mybmirecord/components/textMiddle.dart';

class GridCard{

  Uint8List? imgBytes;
  final String recordDate ;

  GridCard(this.imgBytes, this.recordDate);

  girdCard(double widthsize, double heightsize){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      width: widthsize,
      height: heightsize,
      child: Stack(
        children: [
          Image.memory(imgBytes!,
          fit: BoxFit.contain,
          ),
          Positioned(
            child: Container(
              color: Colors.grey.withAlpha(150),
              width: widthsize,
              height: heightsize*0.2,
              child: TextCustom().customText(recordDate, 7, "c"),

            ),),
        ],
      ),
    );
  }



}